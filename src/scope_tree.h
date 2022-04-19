/*
 * scope_tree.h
 *
 *  Created on: 29-Aug-2019
 *      Authors: Rasika Sapte, Akash Banerjee
 */

#ifndef SCOPE_TREE_H
#define SCOPE_TREE_H

#include "translator.h"

class ll2gb::translator::scope_tree {
	struct scope_node;
	std::map<llvm::DIScope*, scope_node*> scope_scope_node_map;
	static scope_node root;
	void populate_names(std::map<llvm::DIScope*, std::string>*, scope_node*);
	void add_node(llvm::DIScope*);
	void construct_tree(const llvm::Function&);

public:
	scope_tree() {
	}
	~scope_tree() {
		delete_tree();
	}
	void delete_tree();
	void get_scope_name_map(const llvm::Function &F,
			std::map<llvm::DIScope*, std::string> *scope_name_map);
};

#endif /* SCOPE_TREE_H */
