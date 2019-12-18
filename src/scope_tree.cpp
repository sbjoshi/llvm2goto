/*
 * scope_tree.cpp
 *
 *  Created on: 29-Aug-2019
 *      Author: Akash Banerjee
 */

#include "ll2gb.h"
#include "scope_tree.h"

using namespace std;
using namespace llvm;
using namespace ll2gb;

struct translator::scope_tree::scope_node {
	DIScope *scope;
	struct translator::scope_tree::scope_node *parent;
	struct translator::scope_tree::scope_node *left_sibling;
	struct translator::scope_tree::scope_node *right_sibling;
	struct translator::scope_tree::scope_node *first_child;
	struct translator::scope_tree::scope_node *last_child;
	string name;
	scope_node() :
			scope { nullptr },
					parent { nullptr },
					left_sibling { nullptr },
					right_sibling { nullptr },
					first_child { nullptr },
					last_child { nullptr } {
	}

};

translator::scope_tree::scope_node translator::scope_tree::root =
		translator::scope_tree::scope_node();

void translator::scope_tree::delete_tree() {
	scope_scope_node_map.clear();
	root.scope = nullptr;
	root.parent = nullptr;
	root.left_sibling = nullptr;
	root.right_sibling = nullptr;
	root.first_child = nullptr;
	root.last_child = nullptr;
}

void translator::scope_tree::get_scope_name_map(const Function &F,
		map<DIScope*, string> *scope_name_map) {
	construct_tree(F);
	populate_names(scope_name_map, &root);
}

void translator::scope_tree::populate_names(map<DIScope*, string> *scope_name_map,
		scope_node *node) {
	if (node == &root) {
		scope_name_map->insert(pair<DIScope*, string>(node->scope, node->name));
	}
	else {
		string parent_name = scope_name_map->find(node->parent->scope)->second;
		scope_name_map->insert(pair<DIScope*, string>(node->scope,
				parent_name + "::" + node->name));
	}
	scope_node *start = node->first_child;
	while (start != nullptr) {
		populate_names(scope_name_map, start);
		start = start->right_sibling;
	}
}

void translator::scope_tree::add_node(DIScope *new_scope) {
	new_scope->getScope();
	if (isa<DISubprogram>(new_scope)) {
		if (scope_scope_node_map.empty()) {
			root.scope = new_scope;
			if (new_scope->getName() != "") {
				root.name = new_scope->getName();
			}
			else {
				root.name = "0";
			}
			root.left_sibling = nullptr;
			root.right_sibling = nullptr;
			root.first_child = nullptr;
			root.last_child = nullptr;
			scope_scope_node_map.insert(pair<DIScope*, scope_node*>(root.scope,
					&root));
		}
	}
	else {
		if (scope_scope_node_map.find(dyn_cast<DIScope>(new_scope->getScope()))
				== scope_scope_node_map.end()) {
			add_node(dyn_cast<DIScope>(new_scope->getScope()));
		}
		scope_node *node = new scope_node();
		scope_node *parent =
				scope_scope_node_map.find(new_scope->getScope())->second;
		scope_node *left_sibling = parent->last_child;

		node->scope = new_scope;
		node->left_sibling = left_sibling;
		node->right_sibling = nullptr;
		node->parent = parent;
		node->first_child = nullptr;
		node->last_child = nullptr;

		if (left_sibling == nullptr) {
			parent->first_child = node;
			parent->last_child = node;
			if (new_scope->getName() != "") {
				node->name = new_scope->getName();
			}
			else {
				node->name = "0";
			}
		}
		else {
			if (new_scope->getName() != "") {
				node->name = new_scope->getName();
			}
			else {
				node->name = to_string(stoi(left_sibling->name) + 1);
			}
			left_sibling->right_sibling = node;
		}
		parent->last_child = node;
		scope_scope_node_map.insert(pair<DIScope*, scope_node*>(new_scope,
				node));
	}
}

void translator::scope_tree::construct_tree(const Function &F) {
	for (const BasicBlock &B : F)
		for (const Instruction &I : B)
			if (I.hasMetadata()) {
				SmallVector<pair<unsigned, MDNode*>, 4> MDs;
				I.getAllMetadata(MDs);
				for (auto md = MDs.begin(), mde = MDs.end(); md != mde; md++) {
					if (md->second->getMetadataID()
							== Metadata::MetadataKind::DILocationKind) {
						DILocation *loc = dyn_cast<DILocation>(md->second);
						switch (loc->getScope()->getMetadataID()) {
						case Metadata::MetadataKind::DILexicalBlockFileKind: {
							DIScope *S = dyn_cast<DIScope>(loc->getScope());
							S =
									dyn_cast<DILocalScope>(S)->getNonLexicalBlockFileScope();
							if (scope_scope_node_map.find(S)
									== scope_scope_node_map.end()) {
								add_node(S);
							}
							break;
						}
						case Metadata::MetadataKind::DILexicalBlockKind:
						case Metadata::MetadataKind::DISubprogramKind:
						case Metadata::MetadataKind::DIModuleKind:
						case Metadata::MetadataKind::DINamespaceKind:

						case Metadata::MetadataKind::DIBasicTypeKind:
						case Metadata::MetadataKind::DICompositeTypeKind:
						case Metadata::MetadataKind::DIDerivedTypeKind:
						case Metadata::MetadataKind::DISubroutineTypeKind:

						case Metadata::MetadataKind::DIFileKind:
						case Metadata::MetadataKind::DICompileUnitKind:
							DIScope *S = dyn_cast<DIScope>(loc->getScope());
							if (scope_scope_node_map.find(S)
									== scope_scope_node_map.end()) {
								add_node(S);
							}
						}
					}
				}
			}
}
