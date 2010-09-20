from django.db import models
from django.conf import settings
from django.utils.translation import ugettext_lazy as _

#. ---------------------------------------------------------------
# Alphabet Function
def getAlphabet(begin='a', end='z'):
    """
    Return a list of Alphabet entries in a configurable range
    
    Valid Useage
    >>> a = getAlphabet('a', 'c')
    >>> print a
    [('a', 'a'), ('b', 'b'), ('c', 'c')]
    
    Invalid Useage
    >>> a = getAlphabet('z', 'c')
    >>> print a
    []
    """
    dictionary = []
    beginNum = ord(begin)
    endNum = ord(end)
    for number in xrange(beginNum, endNum+1):
        character = chr(number)
        dictionary.append( (character, character) )
    return dictionary

# Alphabet Constant for re-use in context and views
ALPHABET_CHOICES = getAlphabet()

#. ---------------------------------------------------------------
#  Classes for Dictionary Application
#. ---------------------------------------------------------------
class DictionaryManager(models.Manager):
  
  def alphabetized_list(self, valid_letters=[]):
    """
    Return a list of matching alphabet entries if specified, all active entries if none
    """
    alphabet_list = dict({})
    entries = super(DictionaryManager, self).get_query_set().using('default').filter(is_active=True).order_by('alpha_position', 'term')
    
    if valid_letters.count > 0:
      entries = entries.filter(alpha_position__in=valid_letters)
      
    for e in entries:
      alpha = e.alpha_position
      if alphabet_list.has_key(alpha):
        alphabet_list[alpha].append(e)
      else:
        alphabet_list[alpha] = [e]
    
    return alphabet_list
    
  
class Dictionary(models.Model):
  """
  The Dictionary object to store terms and their alphabet association
  
  >>> a = Dictionary(term='A', description='A is for "Apple"', alpha_position='a', is_active=True)
  >>> a.save()
  >>> print a
  A
  >>> b = Dictionary(term='B', description='B is for "Banana"', alpha_position='b', is_active=True)
  >>> b.save()
  >>> print b
  B
  >>> z = Dictionary(term='Z', description='Z is for "Zebra"', alpha_position='z', is_active=True)
  >>> z.save()
  >>> print z
  Z
  
  >>> list_items = Dictionary.objects.alphabetized_list(['a','b'])
  >>> print list_items
  {u'a': [<Dictionary: A>], u'b': [<Dictionary: B>]}
  
  >>> list_items = Dictionary.objects.alphabetized_list(['a','b','z'])
  >>> print list_items
  {u'a': [<Dictionary: A>], u'b': [<Dictionary: B>], u'z': [<Dictionary: Z>]}
  """
  term = models.CharField(max_length=128, blank=False, null=False, verbose_name=_('The Term'), help_text=_('The Term being described'))
  description = models.TextField(blank=False, verbose_name=_('The Explanation'), help_text=_('The description of the term being explained'))
  alpha_position = models.CharField(max_length=2, db_index=True, editable=True, blank=False, null=False, choices=ALPHABET_CHOICES, verbose_name=_('Alphabet Position'), help_text=_('Show this entry under which Alphabet position'))
  is_active = models.BooleanField(default=True, verbose_name=_('Is Active'), help_text=_('Show this entry?'))
  class Meta:
    verbose_name = 'Dictionary entry'
    verbose_name_plural = 'Dictionary entries'
  
  objects = DictionaryManager()
    
  def __unicode__(self):
    return "%s" % self.term
#. ---------------------------------------------------------------