from django import forms
from django.utils.translation import ugettext_lazy as _
from models import Dictionary

#. ---------------------------------------------------------------

class DictionaryForm(forms.ModelForm):
    '''
    A simple form for adding and updating Dictionary records
    
    '''
    alpha_position = forms.CharField(widget=forms.RadioSelect)
    class Meta:
        model = Dictionary
        
#. ---------------------------------------------------------------