from django.conf.urls.defaults import *
from dictionary import views

urlpatterns = patterns('',
    url(r'^$', views.list, name='dictionary_list'),
   (r'^(?P<slug>\w+)/$', 'list_detail.object_detail', {'template': 'dictionary_detail.html'}),
)

