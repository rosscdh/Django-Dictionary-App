"""
The Django Unit Test implementation for the Dictionary Application
Author: Ross Crawford
"""

from django.test import TestCase
from models import *

class DictionaryTest(TestCase):
    def test_valid_alphabet(self):
        """
        Test the getAlphabet function
        """
        a = getAlphabet('a', 'c')
        self.assertEquals(a, [('a', 'a'), ('b', 'b'), ('c', 'c')])
        
    def test_invalid_alphabet(self):
        """
        Test the getAlphabet function
        """
        a = getAlphabet('z', 'c')
        self.assertEquals(a, [])
        
from django.test import Client
csrf_client = Client(enforce_csrf_checks=True)

class DictionaryViewTest(TestCase):
  def setUp(self):
    self.client = Client()
    #self.csrf_client = Client(enforce_csrf_checks=True)
    
  def test_valid_mainview(self):
    response = self.client.get('/dictionary/')
    self.failUnlessEqual(response.status_code, 200)
    
    