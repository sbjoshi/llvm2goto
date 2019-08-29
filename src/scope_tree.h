/*
 * scope_tree.h
 *
 *  Created on: 29-Aug-2019
 *      Author: Akash Banerjee
 */

#ifndef SCOPE_TREE_H
#define SCOPE_TREE_H

#include "translator.h"

using namespace std;
using namespace llvm;
using namespace ll2gb;

class translator::scope_tree {
public:
	scope_tree() {
	}
	~scope_tree() {
		delete_tree();
	}
	void delete_tree();
	void get_scope_name_map(const Function &F,
			map<DIScope*, string> *scope_name_map);

private:
	struct scope_node;
	map<DIScope*, scope_node*> scope_scope_node_map;
	static scope_node root;
	void populate_names(map<DIScope*, string>*, scope_node*);
	void add_node(DIScope*);
	void construct_tree(const Function&);
};

#endif /* SCOPE_TREE_H */
