from datetime import datetime, timedelta
from django.template.context import RequestContext
from django.shortcuts import get_object_or_404, render_to_response
from models import *

# --------------------------------------------------------------------------------
def list(request):
    list_items = Dictionary.objects.alphabetized_list()

    return render_to_response(
        'dictionary/dictionary_list.html', 
        {
          'object_list': list_items,
          'alphabet': ALPHABET_CHOICES
        },
        context_instance=RequestContext(request)
    )
# --------------------------------------------------------------------------------
