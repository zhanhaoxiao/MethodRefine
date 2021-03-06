#!/usr/bin/env python
# coding=utf-8
import sys  
sys.path.insert(0, './') 
from blockworld import *
import new_tihtn_planner
state0 = new_tihtn_planner.State('state0')

allow = False
state0.on = {'block-2':False,'block-3':False,'block-5':'block-1','block-1':False,'block-4':'block-2',}
state0.down = {'block-2':'block-4','block-3':False,'block-5':False,'block-1':'block-5','block-4':False,}
state0.clear = {'block-2':True,'block-3':True,'block-5':False,'block-1':True,'block-4':False,}
state0.on_table = {'block-2':False,'block-3':True,'block-5':True,'block-1':False,'block-4':True,}
state0.holding = False
new_tihtn_planner.declare_types({'block':['block-1','block-2','block-3','block-4','block-5',],'nothing':[()]})
new_tihtn_planner.declare_funs({pick_up:['block'],put_down:['block'],stack:['block', 'block'],checkpile1:['nothing'],checkpile2:['nothing'],checkpile3:['nothing'],checkpile4:['nothing']})
new_tihtn_planner.instance()
def execute(completable):
	return new_tihtn_planner.pyhop(completable, allow, state0,[('tower5','block-1','block-2', 'block-3', 'block-4', 'block-5')], [],9)
def add_methods(fun_obj_list):
	for fun in fun_obj_list:
		new_tihtn_planner.add_method(fun.func_name.split('__')[0], fun)
def reverse_methods():
	new_tihtn_planner.reverse_methods()