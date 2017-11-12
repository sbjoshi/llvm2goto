/* Copyright
Author : Rasika

*/

#include "scope.h"

using namespace llvm;

/*******************************************************************\

   Function: scope_node::scope_node

    Inputs:

    Outputs: 

    Purpose: Constructor for scope_node class.

\*******************************************************************/
scope_node::scope_node()
{
  scope = NULL;
  parent = NULL;
  left_sibling = NULL;
  right_sibling = NULL;
  first_child = NULL;
  last_child = NULL;
}

/*******************************************************************\

   Function: scope_node::~scope_node

    Inputs:

    Outputs: 

    Purpose: Destructor for scope_node class.

\*******************************************************************/
scope_node::~scope_node()
{
  // errs() << "Mr. scope_node : I am dying :)\n";
}

/*******************************************************************\

   Function: scope_tree::scope_tree

    Inputs:

    Outputs: 

    Purpose: Constructor for scope_tree class.

\*******************************************************************/
scope_tree::scope_tree()
{
}

/*******************************************************************\

   Function: scope_tree::~scope_tree

    Inputs:

    Outputs: 

    Purpose: Destructor for scope_tree class.

\*******************************************************************/
scope_tree::~scope_tree()
{
  // errs() << "Mr. scope_tree : I am dying :)\n";
  delete_tree();
}

/*******************************************************************\

   Function: scope_tree::delete_tree

    Inputs:

    Outputs: 

    Purpose: Delete the tree nodes created dynamically.

\*******************************************************************/
void scope_tree::delete_tree()
{
  scope_scope_node_map.erase(root.scope);
  for(auto start = scope_scope_node_map.begin(),
    end = scope_scope_node_map.end();
    start != end; start++)
  {
    start->second->~scope_node();
  }
  root.scope = NULL;
  root.parent = NULL;
  root.left_sibling = NULL;
  root.right_sibling = NULL;
  root.first_child = NULL;
  root.last_child = NULL;
}

/*******************************************************************\

   Function: scope_tree::get_scope_name_map

    Inputs:
            F - llvm function for which scope names are to be found out.
            scope_name_map - Pointer to the map, in which scope and
                             name will be stored.

    Outputs: 

    Purpose: Construct the scope tree and get the name for each scope.

\*******************************************************************/
void scope_tree::get_scope_name_map(const Function &F,
  std::map<DIScope*, std::string> *scope_name_map)
{
  construct_tree(F);
  populate_names(scope_name_map, &root);
}

/*******************************************************************\

   Function: scope_tree::populate_names

    Inputs:
            scope_name_map - Pointer to the map, in which scope and
                             name will be stored.
            node - scope_node to start with. 

    Outputs: 

    Purpose: Traverse the scope_tree to find names of each scope.

\*******************************************************************/
void scope_tree::populate_names(std::map<DIScope*, std::string> *scope_name_map,
  scope_node *node)
{
  if(node == &root)
  {
    scope_name_map->insert(std::pair<DIScope*, std::string>(node->scope,
      node->name));
  }
  else
  {
    std::string parent_name = scope_name_map->find(
      node->parent->scope)->second;
    scope_name_map->insert(std::pair<DIScope*, std::string>(node->scope,
      parent_name + "::" + node->name));
  }
  scope_node *start = node->first_child;
  // *end = node->last_child;
  while(start != NULL)
  {
    populate_names(scope_name_map, start);
    start = start->right_sibling;
  }
}

/*******************************************************************\

   Function: scope_tree::add_node

    Inputs:
            new_scope - pointer to DIScope.

    Outputs: 

    Purpose: Add a scope_node to  the scope_tree.

\*******************************************************************/
void scope_tree::add_node(DIScope *new_scope)
{
  new_scope->getScope();
  if(isa<DISubprogram>(new_scope))
  {
    if(scope_scope_node_map.empty())
    {
      root.scope = new_scope;
      if(new_scope->getName() != "")
      {
        root.name = new_scope->getName();
      }
      else
      {
        root.name = "0";
      }
      root.left_sibling = NULL;
      root.right_sibling = NULL;
      root.first_child = NULL;
      root.last_child = NULL;
      scope_scope_node_map.insert(
        std::pair<DIScope*, scope_node*>(root.scope, &root));
    }
  }
  else
  {
    if(scope_scope_node_map.find(dyn_cast<DIScope>(new_scope->getScope()))
      == scope_scope_node_map.end())
    {
      add_node(dyn_cast<DIScope>(new_scope->getScope()));
    }
    scope_node *node = new scope_node();
    DIScope *bhhoooot = new_scope->getScope().resolve();
    scope_node *pappa = scope_scope_node_map.find(bhhoooot)->second;
    scope_node *left_bro = pappa->last_child;

    node->scope = new_scope;
    node->left_sibling = left_bro;
    node->right_sibling = NULL;
    node->parent = pappa;
    node->first_child = NULL;
    node->last_child = NULL;


    if(left_bro == NULL)
    {
      pappa->first_child = node;
      pappa->last_child = node;
      if(new_scope->getName() != "")
      {
        node->name = new_scope->getName();
      }
      else
      {
        node->name = "0";
      }
    }
    else
    {
      if(new_scope->getName() != "")
      {
        node->name = new_scope->getName();
      }
      else
      {
        node->name = std::to_string(std::stoi(left_bro->name) + 1);
      }
      left_bro->right_sibling = node;
    }
    pappa->last_child = node;
    scope_scope_node_map.insert(
      std::pair<DIScope*, scope_node*>(new_scope, node));
  }
}

/*******************************************************************\

   Function: scope_tree::construct_tree

    Inputs:
            F - llvm function for which scope names are to be found out.

    Outputs: 

    Purpose: Add any new scope in the function F to scope_tree.

\*******************************************************************/
void scope_tree::construct_tree(const Function &F)
{
  for(const BasicBlock &B : F)
  {
    for(const Instruction &I : B)
    {
      if(I.hasMetadata())
      {
        SmallVector<std::pair<unsigned, MDNode *>, 4> MDs;
        I.getAllMetadata(MDs);
        for(auto md = MDs.begin(), mde = MDs.end(); md != mde; md++)
        {
          if(md->second->getMetadataID()
            == Metadata::MetadataKind::DILocationKind)
          {
            DILocation *loc = dyn_cast<DILocation>(md->second);
            switch(loc->getScope()->getMetadataID())
            {
              case llvm::Metadata::MetadataKind::DILexicalBlockFileKind:
              {
                DIScope *S = dyn_cast<DIScope>(loc->getScope());
                S = dyn_cast<DILocalScope>(S)->getNonLexicalBlockFileScope();
                if(scope_scope_node_map.find(S)
                  == scope_scope_node_map.end())
                {
                  S->dump();
                  add_node(S);
                }
                break;
              }
              case llvm::Metadata::MetadataKind::DILexicalBlockKind:
              case llvm::Metadata::MetadataKind::DISubprogramKind:
              case llvm::Metadata::MetadataKind::DIModuleKind:
              case llvm::Metadata::MetadataKind::DINamespaceKind:

              case llvm::Metadata::MetadataKind::DIBasicTypeKind:
              case llvm::Metadata::MetadataKind::DICompositeTypeKind:
              case Metadata::MetadataKind::DIDerivedTypeKind:
              case llvm::Metadata::MetadataKind::DISubroutineTypeKind:

              case llvm::Metadata::MetadataKind::DIFileKind:
              case llvm::Metadata::MetadataKind::DICompileUnitKind:
                DIScope *S = dyn_cast<DIScope>(loc->getScope());
                if(scope_scope_node_map.find(S)
                  == scope_scope_node_map.end())
                {
                  S->dump();
                  add_node(S);
                }
            }
          }
        }
      }
    }
  }
}
