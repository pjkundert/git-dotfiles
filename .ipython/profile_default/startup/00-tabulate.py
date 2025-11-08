import IPython
from tabulate import tabulate

class OrgFormatter(IPython.core.formatters.BaseFormatter):
    def __call__(self, obj):
        try:
            #print( "# org format: for {obj!r}".format(  obj=obj ))
            headers='keys'
            if isinstance( obj, list ) and  obj[1:2] == [ None ]:
                """Recognize [[header, ...], None, [values, ...], [...]]"""
                headers = obj[0]
                obj = obj[2:]
            return tabulate( obj, headers=headers, tablefmt='orgtbl' )
        except Exception as exc:
            #print( "# org format: {exc!r} for {obj!r}".format( exc=exc, obj=obj ))
            return None

ip = get_ipython()
ip.display_formatter.formatters['text/org'] = OrgFormatter()
