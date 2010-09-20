from cms.app_base import CMSApp
#from example.sampleapp.menu import SampleAppMenu
from cms.apphook_pool import apphook_pool
from django.utils.translation import ugettext_lazy as _

class DictionaryApp(CMSApp):
    name = _("Dictionary Application")
    urls = ["dictionary.urls"]

apphook_pool.register(DictionaryApp)