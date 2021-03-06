import os
import sys
import new_tihtn_planner

blockworld_training_path = "/home/cpl/AAAI2020/htn/root_prefer/blocks-world/MethodLearn/blockworld_benchmark-high-reverse/training/"
blockworld_testing_path = "/home/cpl/AAAI2020/htn/root_prefer/blocks-world/MethodLearn/blockworld_benchmark-high-reverse/testing/"
target_path = "./htn_prob/"
sys.path.insert(0, blockworld_training_path)
sys.path.insert(0, blockworld_testing_path)
i = 1
training_files = os.listdir(blockworld_training_path)
training_files.sort()
for training_file in training_files:
    if (training_file.find(".pyc") != -1):
        continue

    exec("from " + training_file.split(".")[0] + " import *")
    fw = open(target_path + str(i) + ".htn", "w")
    fw.write("( define ( htn-problem probname )\n\t( :domain blocks4 )\n\t( :requirements :strips :htn :typing :equality )\n\t( :objects\n")
    for block in new_tihtn_planner.types['block']:
        fw.write("\t\tblock" + block.split("-")[1] + " - block\n")

    fw.write("\t)\n\t( :init\n")
    for down, on in state0.on.items():
        if (on != False):
            fw.write("\t\t( on block" + on.split("-")[1] + " block" + down.split("-")[1] + " )\n")
    for block, flag in state0.on_table.items():
        if (flag != False):
            fw.write("\t\t( on-table block" + block.split("-")[1] + " )\n")
    for block, flag in state0.clear.items():
        if (flag != False):
            fw.write("\t\t( clear block" + block.split("-")[1] + " )\n")
    fw.write("\t\t( hand-empty )\n")
    
    fw.write("\t)\n\t( :tasks\n")
    fw.write("\t\t( make-on-table block1 )\n\t\t( make-on block2 block1 )\n\t\t( make-on block3 block2 )\n\t\t( make-on block4 block3 )\n\t\t( make-on block5 block4 )\n")
    fw.write("\t)\n)")

    fw.close()
    i += 1

testing_files = os.listdir(blockworld_testing_path)
testing_files.sort()
for testing_file in testing_files:
    if (testing_file.find(".pyc") != -1):
        continue
 
    exec("from " + testing_file.split(".")[0] + " import *")
    fw = open(target_path + str(i) + ".htn", "w")
    fw.write("( define ( htn-problem probname )\n\t( :domain blocks4 )\n\t( :requirements :strips :htn :typing :equality )\n\t( :objects\n")
    for block in new_tihtn_planner.types['block']:
        fw.write("\t\tblock" + block.split("-")[1] + " - block\n")

    fw.write("\t)\n\t( :init\n")
    for down, on in state0.on.items():
        if (on != False):
            fw.write("\t\t( on block" + on.split("-")[1] + " block" + down.split("-")[1] + " )\n")
    for block, flag in state0.on_table.items():
        if (flag != False):
            fw.write("\t\t( on-table block" + block.split("-")[1] + " )\n")
    for block, flag in state0.clear.items():
        if (flag != False):
            fw.write("\t\t( clear block" + block.split("-")[1] + " )\n")
    fw.write("\t\t( hand-empty )\n")
    
    fw.write("\t)\n\t( :tasks\n")
    fw.write("\t\t( make-on-table block1 )\n\t\t( make-on block2 block1 )\n\t\t( make-on block3 block2 )\n\t\t( make-on block4 block3 )\n\t\t( make-on block5 block4 )\n")
    fw.write("\t)\n)")

    fw.close()
    i += 1