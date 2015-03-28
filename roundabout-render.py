#!/usr/bin/python

import os, sys
from dotscad import Customizer

if __name__ == '__main__':
    os.chdir(os.path.dirname(os.path.abspath(__file__)))
    os.makedirs('roundabout-stl')
    s = Customizer('roundabout.scad', debug=False)
    for part in s.vars['part'].possible.parameters.keys():
        shortname = s.vars['part'].possible[part]
        s.vars['part'].set(shortname)
        name = 'roundabout-stl/roundabout-{0}'.format(shortname.replace('_','-'))
        print name
        s.render_stl(name)
