/* Copyright
Author : Rasika

*/
#include <iostream>
#include <memory>
#include <utility>
#include <map>
#include <string>


#include "llvm/IR/Function.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/DebugInfoMetadata.h"

using namespace llvm;
#ifndef SRC_SCOPE_H_
#define SRC_SCOPE_H_
class scope_node
{
 public:
  DIScope *scope;
  scope_node *parent;
  scope_node *left_sibling;
  scope_node *right_sibling;
  scope_node *first_child;
  scope_node *last_child;
  std::string name;
  scope_node();
  ~scope_node();
};

class scope_tree
{
 public:
  scope_tree();
  ~scope_tree();
  void delete_tree();
  void get_scope_name_map(const Function &F,
    std::map<DIScope*, std::string> *scope_name_map);

 private:
  std::map<DIScope*, scope_node*> scope_scope_node_map;
  scope_node root;
  void populate_names(std::map<DIScope*, std::string> *scope_name_map,
    scope_node *node);
  void add_node(DIScope *new_scope);
  void construct_tree(const Function &F);
};
#endif  // SRC_SCOPE_H_"
