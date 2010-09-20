from django.contrib.contenttypes import generic
from django.contrib import admin
#from markitup.widgets import AdminMarkItUpWidget
from dictionary.models import *

class DictionaryAdmin(admin.ModelAdmin):
    list_display = ('term', 'description',)
    list_filter = ('alpha_position',)
    search_fields = ('term', 'description',)
    # def formfield_for_dbfield(self, db_field, **kwargs):
    #     if db_field.name == 'description':
    #         kwargs['widget'] = AdminMarkItUpWidget()
    #     return super(DictionaryAdmin, self).formfield_for_dbfield(db_field, **kwargs)
        
admin.site.register(Dictionary, DictionaryAdmin)