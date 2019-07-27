/* Copyright
 Author : Rasika

 */
#include "symbol_creator.h"
#include "locationt.h"

#include "llvm/Support/raw_ostream.h"

#include "util/arith_tools.h"
#include "util/std_expr.h"
#include "util/ieee_float.h"
#include "util/c_types.h"
#include "util/config.h"

// Language mode is temporarily set to 'C'.
// TODO(Rasika) : set the appropriate width of array size.
// TODO(Rasika) : Initial value of symbol.
// TODO(Rasika) : The unique identifier.
// TODO(Rasika) : Name of module the symbol belongs to.
// TODO(Rasika) : Base (non-scoped) name.
// TODO(Rasika) : Language-specificname.
// TODO(Rasika) : 128-bit floating point type (112-bit mantissa) FP128Ty
// TODO(Rasika) : 128-bit floating point type (two 64-bits, PowerPC) PPC_FP128Ty

int get_encoding(const llvm::DIType *md) {
  if (auto *temp = dyn_cast<DICompositeType>(md)) {
    if (!temp->getBaseType()) return -10;
    return get_encoding(dyn_cast<DIType>(temp->getBaseType()));
  }
  else if (auto *temp = dyn_cast<DIDerivedType>(md)) {
    if (!temp->getBaseType()) return -10;
    if (temp->getNumOperands()) return get_encoding(
        dyn_cast<DIType>(temp->getBaseType()));
  }
  else if (auto *temp = dyn_cast<DIBasicType>(md)) {
    if (!temp) return -10;
    return temp->getEncoding();
  }

  return -1;
}
/*******************************************************************
 Function: symbol_creator::create_HalfTy

 Inputs:
 GV - reference to global variable in llvm module.
 name - name of the global variable

 Outputs: Object of symbolt.

 Purpose: Create 16 bit floatbv symbol.

 \*******************************************************************/
symbolt symbol_creator::create_HalfTy(Type *type, MDNode *mdn) {
  symbolt global_variable;
  global_variable.clear();
  if (dyn_cast<DIGlobalVariable>(mdn)) {
    global_variable.is_static_lifetime = true;
  }
  bitvector_typet bvt(ID_floatbv, 16);
  global_variable.type = to_floatbv_type(bvt);
  global_variable.location = locationt::get_location_global_variable(mdn);
  const irep_idt tmp_name = dyn_cast<DIVariable>(mdn)->getName().str();
  global_variable.base_name = tmp_name;
  global_variable.mode = ID_C;
  return global_variable;
}

/*******************************************************************
 Function: symbol_creator::create_FloatTy

 Inputs:
 GV - reference to global variable in llvm module.
 name - name of the global variable

 Outputs: Object of symbolt.

 Purpose: Create 32 bit floatbv symbol.

 \*******************************************************************/
symbolt symbol_creator::create_FloatTy(Type *type, MDNode *mdn) {
  symbolt global_variable;
  global_variable.clear();
  if (dyn_cast<DIGlobalVariable>(mdn)) {
    global_variable.is_static_lifetime = true;
  }
  // bitvector_typet bvt(ID_floatbv, 32);
  floatbv_typet bvt = ieee_float_spect::single_precision().to_type();
  bvt.set(ID_C_c_type, ID_float);
  global_variable.type = to_floatbv_type(bvt);
  global_variable.location = locationt::get_location_global_variable(mdn);
  const irep_idt tmp_name = dyn_cast<DIVariable>(mdn)->getName().str();
  global_variable.base_name = tmp_name;
  global_variable.mode = ID_C;
  return global_variable;
}

/*******************************************************************
 Function: symbol_creator::create_DoubleTy

 Inputs:
 GV - reference to global variable in llvm module.
 name - name of the global variable

 Outputs: Object of symbolt.

 Purpose: Create 64 bit floatbv symbol.

 \*******************************************************************/
symbolt symbol_creator::create_DoubleTy(Type *type, MDNode *mdn) {
  symbolt global_variable;
  global_variable.clear();
  if (dyn_cast<DIGlobalVariable>(mdn)) {
    global_variable.is_static_lifetime = true;
  }
  // bitvector_typet bvt(ID_floatbv, 64);
  floatbv_typet bvt = ieee_float_spect::double_precision().to_type();
  bvt.set(ID_C_c_type, ID_double);
  global_variable.type = to_floatbv_type(bvt);
  global_variable.location = locationt::get_location_global_variable(mdn);
  const irep_idt tmp_name = dyn_cast<DIVariable>(mdn)->getName().str();
  global_variable.base_name = tmp_name;
  global_variable.mode = ID_C;
  return global_variable;
}

/*******************************************************************
 Function: symbol_creator::create_X86_FP80Ty

 Inputs:
 GV - reference to global variable in llvm module.
 name - name of the global variable

 Outputs: Object of symbolt.

 Purpose: Create 80 bit floatbv symbol.

 \*******************************************************************/
symbolt symbol_creator::create_X86_FP80Ty(Type *type, MDNode *mdn) {
  symbolt global_variable;
  global_variable.clear();
  if (dyn_cast<DIGlobalVariable>(mdn)) {
    global_variable.is_static_lifetime = true;
  }
  bitvector_typet bvt(ID_floatbv, 80);
  global_variable.type = to_floatbv_type(bvt);
  global_variable.location = locationt::get_location_global_variable(mdn);
  const irep_idt tmp_name = dyn_cast<DIVariable>(mdn)->getName().str();
  global_variable.base_name = tmp_name;
  global_variable.mode = ID_C;
  return global_variable;
}

/*******************************************************************
 Function: symbol_creator::create_FP128Ty

 Inputs:
 GV - reference to global variable in llvm module.
 name - name of the global variable

 Outputs: Object of symbolt.

 Purpose: Create 128 bit floatbv symbol.

 \*******************************************************************/
symbolt symbol_creator::create_FP128Ty(Type *type, MDNode *mdn) {
  symbolt global_variable;
  global_variable.clear();
  if (dyn_cast<DIGlobalVariable>(mdn)) {
    global_variable.is_static_lifetime = true;
  }
  bitvector_typet bvt(ID_floatbv, 128);
  global_variable.type = to_floatbv_type(bvt);
  global_variable.location = locationt::get_location_global_variable(mdn);
  const irep_idt tmp_name = dyn_cast<DIVariable>(mdn)->getName().str();
  global_variable.base_name = tmp_name;
  global_variable.mode = ID_C;
  return global_variable;
}

/*******************************************************************
 Function: symbol_creator::create_PPC_FP128Ty

 Inputs:
 GV - reference to global variable in llvm module.
 name - name of the global variable

 Outputs: Object of symbolt.

 Purpose: Create 128 bit floatbv symbol.

 \*******************************************************************/
symbolt symbol_creator::create_PPC_FP128Ty(Type *type, MDNode *mdn) {
  symbolt global_variable;
  global_variable.clear();
  if (dyn_cast<DIGlobalVariable>(mdn)) {
    global_variable.is_static_lifetime = true;
  }
  bitvector_typet bvt(ID_floatbv, 128);
  global_variable.type = to_floatbv_type(bvt);
  global_variable.location = locationt::get_location_global_variable(mdn);
  const irep_idt tmp_name = dyn_cast<DIVariable>(mdn)->getName().str();
  global_variable.base_name = tmp_name;
  global_variable.mode = ID_C;
  return global_variable;
}

/*******************************************************************
 Function: symbol_creator::create_X86_MMXTy

 Inputs:
 GV - reference to global variable in llvm module.
 name - name of the global variable

 Outputs: Object of symbolt.

 Purpose: Create apropriate goto symbol.

 \*******************************************************************/
symbolt symbol_creator::create_X86_MMXTy(Type *type, MDNode *mdn) {
  symbolt global_variable;
  global_variable.clear();
  global_variable.location = locationt::get_location_global_variable(
      dyn_cast<DIVariable>(mdn));
  const irep_idt tmp_name = dyn_cast<DIVariable>(mdn)->getName().str();
  global_variable.base_name = tmp_name;
  if (dyn_cast<DIGlobalVariable>(mdn)) {
    global_variable.is_static_lifetime = true;
  }
  return global_variable;
}

/*******************************************************************
 Function: symbol_creator::create_IntegerTy

 Inputs:
 GV - reference to global variable in llvm module.
 name - name of the global variable

 Outputs: Object of symbolt.

 Purpose: Create bool_typet or unsignedbv_typet symbol.

 \*******************************************************************/
symbolt symbol_creator::create_IntegerTy(Type *type, MDNode *mdn) {
  symbolt variable;
  variable.clear();
  if (dyn_cast<DIGlobalVariable>(mdn)) {
    variable.is_static_lifetime = true;
  }
  if (type->getIntegerBitWidth() == 1) {
    variable.type = bool_typet();
  }
  else if (type->getIntegerBitWidth() == 8) {
    variable.type = signed_char_type();
  }
  else if (type->getIntegerBitWidth() == 64) {
    variable.type = signed_long_int_type();
  }
  else {
    variable.type = signed_int_type();
  }
  DIType *type1 = dyn_cast<DIType>(dyn_cast<DIVariable>(mdn)->getType());
  while (type1->getTag() == dwarf::DW_TAG_typedef)
    type1 = dyn_cast<DIType>(dyn_cast<DIDerivedType>(type1)->getBaseType());
//  while (dyn_cast<DIDerivedType>(type1)) {
//    type1 = dyn_cast<DIType>(
//        &(*(dyn_cast<DIDerivedType>(type1)->getBaseType())));
//  }
  int encoding = get_encoding(type1);
  switch (encoding) {
    case dwarf::DW_ATE_signed: {
      variable.type = signed_int_type();
      break;
    }
    case dwarf::DW_ATE_signed_char: {
      // case dwarf::DW_EH_PE_signed :
      variable.type = signed_char_type();
      break;
    }
    case dwarf::DW_ATE_unsigned_char: {
      // case dwarf::DW_EH_PE_signed :
//          ele_type = signedbv_typet(type->getIntegerBitWidth());
      variable.type = unsigned_char_type();
      break;
    }
    case dwarf::DW_ATE_unsigned: {
      // case dwarf::DW_EH_PE_signed :
      variable.type = unsigned_int_type();
      break;
    }
    case -10: {
      variable.type = void_typet();
      break;
    }
    default: {
      variable.type = signedbv_typet(type->getIntegerBitWidth());
      break;
    }
  }
  if (dyn_cast<DIGlobalVariable>(mdn) != NULL) {
    variable.location = locationt::get_location_global_variable(mdn);
    const irep_idt tmp_name = dyn_cast<DIGlobalVariable>(mdn)->getName().str();
    variable.base_name = tmp_name;
  }
  else if (dyn_cast<DILocalVariable>(mdn) != NULL) {
    variable.location = locationt::get_location_global_variable(mdn);
    const irep_idt tmp_name = dyn_cast<DILocalVariable>(mdn)->getName().str();
    variable.base_name = tmp_name;
  }
  variable.mode = ID_C;
  return variable;
}

/*******************************************************************
 Function: symbol_creator::create_StructTy

 Inputs:
 GV - reference to global variable in llvm module.
 name - name of the global variable

 Outputs: Object of symbolt.

 Purpose: Create apropriate goto symbol in symbol table corresponding to
 llvm global variable.

 \*******************************************************************/
symbolt symbol_creator::create_StructTy(Type *type, const llvm::MDNode *mdn) {
  symbolt global_variable;
  global_variable.clear();
  if (dyn_cast<DIGlobalVariable>(mdn)) {
    global_variable.is_static_lifetime = true;
  }
  struct_typet sut;
  struct_typet::componentst &components = sut.components();
  DIType *temp = dyn_cast<DIType>(dyn_cast<DIVariable>(mdn)->getType());
  while (temp->getTag() == dwarf::DW_TAG_typedef)
    temp = dyn_cast<DIType>(dyn_cast<DIDerivedType>(temp)->getBaseType());

  DICompositeType *md = dyn_cast<DICompositeType>(temp);
  DINodeArray Fields = md->getElements();
  int i = 0;
  for (StructType::element_iterator e = dyn_cast<StructType>(type)
      ->element_begin(); e != dyn_cast<StructType>(type)->element_end(); e++) {
    irep_idt ele_name = dyn_cast<DIType>(Fields[i])->getName().str();
    switch ((*e)->getTypeID()) {
      case llvm::Type::TypeID::HalfTyID: {
        bitvector_typet bvt(ID_floatbv, 16);
        struct_typet::componentt component(ele_name, to_floatbv_type(bvt));
        components.push_back(component);
        break;
      }
      case llvm::Type::TypeID::FloatTyID: {
        bitvector_typet bvt(ID_floatbv, 32);
        struct_typet::componentt component(ele_name, to_floatbv_type(bvt));
        components.push_back(component);
        break;
      }
      case llvm::Type::TypeID::DoubleTyID: {
        bitvector_typet bvt(ID_floatbv, 64);
        struct_typet::componentt component(ele_name, to_floatbv_type(bvt));
        components.push_back(component);
        break;
      }
      case llvm::Type::TypeID::X86_FP80TyID: {
        bitvector_typet bvt(ID_floatbv, 80);
        struct_typet::componentt component(ele_name, to_floatbv_type(bvt));
        components.push_back(component);
        break;
      }
      case llvm::Type::TypeID::FP128TyID: {
        bitvector_typet bvt(ID_floatbv, 128);
        struct_typet::componentt component(ele_name, to_floatbv_type(bvt));
        components.push_back(component);
        break;
      }
      case llvm::Type::TypeID::PPC_FP128TyID: {
        bitvector_typet bvt(ID_floatbv, 128);
        struct_typet::componentt component(ele_name, to_floatbv_type(bvt));
        components.push_back(component);
        break;
      }
      case llvm::Type::TypeID::IntegerTyID: {
        auto temp_type = Fields[i];
        if ((*e)->getIntegerBitWidth() == 1) {
          struct_typet::componentt component(ele_name, bool_typet());
          components.push_back(component);
          break;
        }

        while (dyn_cast<DIDerivedType>(temp_type)
            || dyn_cast<DICompositeType>(temp_type)) {
          if (DIDerivedType* temp = dyn_cast<DIDerivedType>(temp_type)) temp_type =
              dyn_cast<DIType>(temp->getBaseType());
          if (DICompositeType* temp = dyn_cast<DICompositeType>(temp_type)) temp_type =
              dyn_cast<DIType>(temp->getBaseType());
        }

        struct_typet::componentt component(
            ele_name, unsignedbv_typet((*e)->getIntegerBitWidth()));

        int encoding;
        if (dyn_cast<DIBasicType>(temp_type)) {
          encoding = dyn_cast<DIBasicType>(temp_type)->getEncoding();
        }
        else {
          component = struct_typet::componentt(
              ele_name, signedbv_typet((*e)->getIntegerBitWidth()));
          components.push_back(component);
          break;
        }
//        encoding = get_encoding(md);
        switch (encoding) {
          case dwarf::DW_ATE_signed: {
            component = struct_typet::componentt(ele_name, signed_int_type());
            break;
          }
          case dwarf::DW_ATE_unsigned: {
            component = struct_typet::componentt(ele_name, unsigned_int_type());
            break;
          }
          case dwarf::DW_ATE_signed_char: {
            component = struct_typet::componentt(ele_name, signed_char_type());
            break;
          }
          case dwarf::DW_ATE_unsigned_char: {
            component = struct_typet::componentt(ele_name,
                                                 unsigned_char_type());
            break;
          }
          case -10: {
            component = struct_typet::componentt(ele_name, void_typet());
            break;
          }
          default: {
            component = struct_typet::componentt(
                ele_name, signedbv_typet((*e)->getIntegerBitWidth()));
            break;
          }
        }
        components.push_back(component);
        break;
      }
      case llvm::Type::TypeID::StructTyID: {
        MDNode *ele_type;
        if (dyn_cast<DIDerivedType>(Fields[i])) {
          ele_type = dyn_cast<MDNode>(
              dyn_cast<DIDerivedType>(Fields[i])->getBaseType());
        }
        else {
          errs() << "\n Unhandled datatype in :\n";
          Fields[i]->dump();
        }
        struct_typet::componentt component(
            ele_name,
            create_struct_union_type(*e, dyn_cast<DICompositeType>(ele_type)));
        components.push_back(component);
        break;
      }
      case llvm::Type::TypeID::ArrayTyID: {
        Type *mew = *e;
        dyn_cast<ArrayType>(mew);
        exprt size = from_integer(dyn_cast<ArrayType>(*e)->getNumElements(),
                                  signedbv_typet(32));
        typet arrt = create_array_type(
            *e,
            dyn_cast<DICompositeType>(
                dyn_cast<DIDerivedType>(Fields[i])->getBaseType()));
        struct_typet::componentt component(ele_name, array_typet(arrt, size));
        components.push_back(component);
        break;
      }
      case llvm::Type::TypeID::PointerTyID: {
        typet ptr_type = create_pointer_type(
            *e,
            dyn_cast<DIDerivedType>(
                dyn_cast<DIDerivedType>(Fields[i])->getBaseType()));
        pointer_typet pt(ptr_type, config.ansi_c.pointer_width);
        struct_typet::componentt component(ele_name, pt);
        components.push_back(component);
        break;
      }
      case llvm::Type::TypeID::VectorTyID: {
        errs() << "VectorTyID NO ACTION TAKEN\n";
        // struct_union_typet::componentt component(ele_name, _ID);
        // components.push_back(component);
        break;
      }
      case llvm::Type::TypeID::X86_MMXTyID: {
        errs() << "X86_MMXTyID NO ACTION TAKEN\n";
        // struct_union_typet::componentt component(ele_name, _ID);
        // components.push_back(component);
        break;
      }
      case llvm::Type::TypeID::VoidTyID: {
        errs() << "VoidTyID NO ACTION TAKEN\n";
        // struct_union_typet::componentt component(ele_name, _ID);
        // components.push_back(component);
        break;
      }
      case llvm::Type::TypeID::FunctionTyID: {
        errs() << "FunctionTyID NO ACTION TAKEN\n";
        // struct_union_typet::componentt component(ele_name, _ID);
        // components.push_back(component);
        break;
      }
      case llvm::Type::TypeID::TokenTyID: {
        errs() << "TokenTyID NO ACTION TAKEN\n";
        // struct_union_typet::componentt component(ele_name, _ID);
        // components.push_back(component);
        break;
      }
      case llvm::Type::TypeID::LabelTyID: {
        errs() << "LabelTyID NO ACTION TAKEN\n";
        // struct_union_typet::componentt component(ele_name, _ID);
        // components.push_back(component);
        break;
      }
      case llvm::Type::TypeID::MetadataTyID: {
        errs() << "MetadataTyID NO ACTION TAKEN\n";
        // struct_union_typet::componentt component(ele_name, _ID);
        // components.push_back(component);
        break;
      }
      default:
        break;
    }
    i++;
  }

  global_variable.type = sut;
  global_variable.location = locationt::get_location_global_variable(
      dyn_cast<DIVariable>(mdn));
  const irep_idt tmp_name = dyn_cast<DIVariable>(mdn)->getName().str();
  global_variable.base_name = tmp_name;
  global_variable.mode = ID_C;
  return global_variable;
}

/*******************************************************************
 Function: symbol_creator::create_struct_union_type

 Inputs:
 GV - reference to global variable in llvm module.
 md - pointer to DICompositeType.

 Outputs: Object of struct_union_typet.

 Purpose: Create apropriate goto symbol typet corresponding to given
 llvm struct type.

 \*******************************************************************/
struct_union_typet symbol_creator::create_struct_union_type(
    Type *type, const llvm::DIType *md) {
  struct_union_typet sut(ID_struct);
  while (md->getTag() == dwarf::DW_TAG_typedef)
    md = dyn_cast<DIType>(dyn_cast<DIDerivedType>(md)->getBaseType());
  struct_union_typet::componentst &components = sut.components();
  DINodeArray Fields = dyn_cast<DICompositeType>(md)->getElements();
  int i = 0;
  for (StructType::element_iterator e = dyn_cast<StructType>(type)
      ->element_begin(); e != dyn_cast<StructType>(type)->element_end(); e++) {
    irep_idt ele_name = dyn_cast<DIDerivedType>(Fields[i])->getName().str();
    switch ((*e)->getTypeID()) {
      case llvm::Type::TypeID::HalfTyID: {
        bitvector_typet bvt(ID_floatbv, 16);
        struct_union_typet::componentt component(ele_name,
                                                 to_floatbv_type(bvt));
        components.push_back(component);
        break;
      }
      case llvm::Type::TypeID::FloatTyID: {
        bitvector_typet bvt(ID_floatbv, 32);
        struct_union_typet::componentt component(ele_name,
                                                 to_floatbv_type(bvt));
        components.push_back(component);
        break;
      }
      case llvm::Type::TypeID::DoubleTyID: {
        bitvector_typet bvt(ID_floatbv, 64);
        struct_union_typet::componentt component(ele_name,
                                                 to_floatbv_type(bvt));
        components.push_back(component);
        break;
      }
      case llvm::Type::TypeID::X86_FP80TyID: {
        bitvector_typet bvt(ID_floatbv, 80);
        struct_union_typet::componentt component(ele_name,
                                                 to_floatbv_type(bvt));
        components.push_back(component);
        break;
      }
      case llvm::Type::TypeID::FP128TyID: {
        bitvector_typet bvt(ID_floatbv, 128);
        struct_union_typet::componentt component(ele_name,
                                                 to_floatbv_type(bvt));
        components.push_back(component);
        break;
      }
      case llvm::Type::TypeID::PPC_FP128TyID: {
        bitvector_typet bvt(ID_floatbv, 128);
        struct_union_typet::componentt component(ele_name,
                                                 to_floatbv_type(bvt));
        components.push_back(component);
        break;
      }
      case llvm::Type::TypeID::IntegerTyID: {
        if ((*e)->getIntegerBitWidth() == 1) {
          struct_union_typet::componentt component(ele_name, bool_typet());
          components.push_back(component);
        }
        int encoding;
        encoding = get_encoding(
            dyn_cast<DIType>(
                dyn_cast<DIDerivedType>(Fields[i])->getBaseType()));
        struct_union_typet::componentt component;
        switch (encoding) {
          case dwarf::DW_ATE_signed: {
            component = struct_typet::componentt(ele_name, signed_int_type());
            break;
          }
          case dwarf::DW_ATE_unsigned: {
            component = struct_typet::componentt(ele_name, unsigned_int_type());
            break;
          }
          case dwarf::DW_ATE_signed_char: {
            component = struct_typet::componentt(ele_name, signed_char_type());
            break;
          }
          case dwarf::DW_ATE_unsigned_char: {
            component = struct_typet::componentt(ele_name,
                                                 unsigned_char_type());
            break;
          }
          case -10: {
            component = struct_typet::componentt(ele_name, void_typet());
            break;
          }
          default: {
            component = struct_typet::componentt(
                ele_name, signedbv_typet((*e)->getIntegerBitWidth()));
            break;
          }
        }
        components.push_back(component);
        break;
      }
      case llvm::Type::TypeID::StructTyID: {
        MDNode *ele_type;
        if (dyn_cast<DIDerivedType>(Fields[i])) {
          ele_type = dyn_cast<MDNode>(
              dyn_cast<DIDerivedType>(Fields[i])->getBaseType());
        }
        else {
          errs() << "\n Unhandled datatype in :\n";
          Fields[i]->dump();
        }
        struct_union_typet::componentt component(
            ele_name,
            create_struct_union_type(*e, dyn_cast<DICompositeType>(ele_type)));
        components.push_back(component);
        break;
      }
      case llvm::Type::TypeID::ArrayTyID: {
        struct_union_typet::componentt component(
            ele_name,
            array_typet(
                create_array_type(
                    *e,
                    dyn_cast<DICompositeType>(
                        dyn_cast<DIDerivedType>(Fields[i])->getBaseType())),
                from_integer((*e)->getArrayNumElements(), size_type())));
        components.push_back(component);
        break;
      }
      case llvm::Type::TypeID::PointerTyID: {
        typet ptr_type = create_pointer_type(
            *e,
            dyn_cast<DIDerivedType>(
                dyn_cast<DIDerivedType>(Fields[i])->getBaseType()));
        pointer_typet pt(ptr_type, config.ansi_c.pointer_width);
        struct_union_typet::componentt component(ele_name, pt);
        components.push_back(component);
        break;
      }
      case llvm::Type::TypeID::VectorTyID: {
        errs() << "VectorTyID NO ACTION TAKEN\n";
        // struct_union_typet::componentt component(ele_name, _ID);
        // components.push_back(component);
        break;
      }
      case llvm::Type::TypeID::X86_MMXTyID: {
        errs() << "X86_MMXTyID NO ACTION TAKEN\n";
        // struct_union_typet::componentt component(ele_name, _ID);
        // components.push_back(component);
        break;
      }
      case llvm::Type::TypeID::VoidTyID: {
        errs() << "VoidTyID NO ACTION TAKEN\n";
        // struct_union_typet::componentt component(ele_name, _ID);
        // components.push_back(component);
        break;
      }
      case llvm::Type::TypeID::FunctionTyID: {
        errs() << "FunctionTyID NO ACTION TAKEN\n";
        // struct_union_typet::componentt component(ele_name, _ID);
        // components.push_back(component);
        break;
      }
      case llvm::Type::TypeID::TokenTyID: {
        errs() << "TokenTyID NO ACTION TAKEN\n";
        // struct_union_typet::componentt component(ele_name, _ID);
        // components.push_back(component);
        break;
      }
      case llvm::Type::TypeID::LabelTyID: {
        errs() << "LabelTyID NO ACTION TAKEN\n";
        // struct_union_typet::componentt component(ele_name, _ID);
        // components.push_back(component);
        break;
      }
      case llvm::Type::TypeID::MetadataTyID: {
        errs() << "MetadataTyID NO ACTION TAKEN\n";
        // struct_union_typet::componentt component(ele_name, _ID);
        // components.push_back(component);
        break;
      }
      default:
        break;
    }
    i++;
  }
  return sut;
}

/*******************************************************************
 Function: symbol_creator::create_ArrayTy

 Inputs:
 GV - reference to global variable in llvm module.
 name - name of the global variable

 Outputs: Object of symbolt.

 Purpose: Create apropriate goto symbol in symbol table corresponding to
 llvm global variable.

 \*******************************************************************/
symbolt symbol_creator::create_ArrayTy(Type *type, MDNode *mdn) {
  symbolt global_variable;
  global_variable.clear();
  if (dyn_cast<DIGlobalVariable>(mdn)) {
    global_variable.is_static_lifetime = true;
  }
  errs() << "0\n";
  exprt size = from_integer(type->getArrayNumElements(), size_type());
  errs() << "1\n";
  DIType *md = dyn_cast<DIType>(dyn_cast<DIVariable>(mdn)->getType());
  while (md->getTag() == dwarf::DW_TAG_typedef)
    md = dyn_cast<DIType>(dyn_cast<DIDerivedType>(md)->getBaseType());
  md->dump();
  errs() << "2\n";
  array_typet arrt(create_array_type(type, dyn_cast<DIType>(md)), size);
  global_variable.type = arrt;
  errs() << "3\n";
  mdn->dump();
  errs() << "4\n";
  dyn_cast<DIVariable>(mdn)->dump();
  errs() << "5\n";
  global_variable.location = locationt::get_location_global_variable(
      dyn_cast<DIVariable>(mdn));
  errs() << "6\n";
  const irep_idt tmp_name = dyn_cast<DIVariable>(mdn)->getName().str();
  errs() << "7\n";
  global_variable.base_name = tmp_name;
  global_variable.mode = ID_C;
  return global_variable;
}

/*******************************************************************
 Function: symbol_creator::create_array_type

 Inputs:
 GV - reference to global variable in llvm module.
 md - pointer to DICompositeType.

 Outputs: Object of struct_union_typet.

 Purpose: Create apropriate goto symbol typet corresponding to given
 llvm array type.

 \*******************************************************************/
typet symbol_creator::create_array_type(Type *type, llvm::DIType *md) {
  while (md->getTag() == dwarf::DW_TAG_typedef)
    md = dyn_cast<DIType>(dyn_cast<DIDerivedType>(md)->getBaseType());
  md->dump();
  type->dump();
  dyn_cast<ArrayType>(type)->dump();
  errs()
      << (dyn_cast<ArrayType>(type)->getArrayElementType()->getTypeID()
          == Type::TypeID::ArrayTyID)
      << "yes";
  typet ele_type;
  switch (dyn_cast<ArrayType>(type)->getArrayElementType()->getTypeID()) {
    // 16-bit floating point type
    case llvm::Type::TypeID::HalfTyID: {
      ele_type = to_floatbv_type(bitvector_typet(ID_floatbv, 16));
      break;
    }
      // 32-bit floating point type
    case llvm::Type::TypeID::FloatTyID: {
      ele_type = to_floatbv_type(bitvector_typet(ID_floatbv, 32));
      break;
    }
      // 64-bit floating point type
    case llvm::Type::TypeID::DoubleTyID: {
      ele_type = to_floatbv_type(bitvector_typet(ID_floatbv, 64));
      break;
    }
      // 80-bit floating point type (X87)
    case llvm::Type::TypeID::X86_FP80TyID: {
      ele_type = to_floatbv_type(bitvector_typet(ID_floatbv, 80));
      break;
    }
      // 128-bit floating point type (112-bit mantissa)
    case llvm::Type::TypeID::FP128TyID: {
      ele_type = to_floatbv_type(bitvector_typet(ID_floatbv, 128));
      break;
    }
      // 128-bit floating point type (two 64-bits, PowerPC)
    case llvm::Type::TypeID::PPC_FP128TyID: {
      ele_type = to_floatbv_type(bitvector_typet(ID_floatbv, 128));
      break;
    }
    case llvm::Type::TypeID::IntegerTyID: {
      if (dyn_cast<ArrayType>(type)->getArrayElementType()->getIntegerBitWidth()
          == 1) {
        ele_type = bool_typet();
      }
      else {
        ele_type =
            unsignedbv_typet(
                dyn_cast<ArrayType>(type)->getArrayElementType()
                    ->getIntegerBitWidth());
        errs() << (md == NULL) << "\n";
        md->dump();
        int encoding = get_encoding(md);
//        auto temp = md;
//        if (dyn_cast<DIBasicType>(md)) {
//          encoding = dyn_cast<DIBasicType>(md)->getEncoding();
//        }
//        else if (dyn_cast<DICompositeType>(md)) {
//          encoding = dyn_cast<DIBasicType>(
//              dyn_cast<DICompositeType>(md)->getBaseType())->getEncoding();
//        }
        switch (encoding) {
          case dwarf::DW_ATE_signed: {
            ele_type = signed_int_type();
            break;
          }
          case dwarf::DW_ATE_unsigned: {
            // case dwarf::DW_EH_PE_signed :
            ele_type = unsigned_int_type();
            break;
          }
          case dwarf::DW_ATE_signed_char: {
            // case dwarf::DW_EH_PE_signed :
            ele_type = signed_char_type();
            break;
          }
          case dwarf::DW_ATE_unsigned_char: {
            // case dwarf::DW_EH_PE_signed :
            ele_type = unsigned_char_type();
            break;
          }
          case -10: {
            ele_type = void_typet();
            break;
          }
          default: {
            ele_type = signedbv_typet(
                dyn_cast<ArrayType>(type)->getArrayElementType()
                    ->getIntegerBitWidth());
            break;
          }
        }
      }
      break;
    }
    case llvm::Type::TypeID::StructTyID: {
      if (dyn_cast<DICompositeType>(md)) {
        md = dyn_cast<DIType>(dyn_cast<DICompositeType>(md)->getBaseType());
      }
      else if (dyn_cast<DIDerivedType>(md)) {
        md = dyn_cast<DIType>(dyn_cast<DIDerivedType>(md)->getBaseType());
      }
      while (!dyn_cast<DICompositeType>(md))
        if (dyn_cast<DIDerivedType>(md)) {
          md = dyn_cast<DIType>(dyn_cast<DIDerivedType>(md)->getBaseType());
        }
        else
          assert(false && "Akash please fix me");

      ele_type = create_struct_union_type(
          dyn_cast<ArrayType>(type)->getArrayElementType(), md);
      break;
    }
    case llvm::Type::TypeID::ArrayTyID: {
      auto array_element = type->getArrayElementType();

      exprt size = from_integer(array_element->getArrayNumElements(),
                                size_type());
      if (array_element->getArrayElementType()->isIntegerTy()) {

      }
      array_element->dump();

      if (dyn_cast<DICompositeType>(md)) {
        md = dyn_cast<DIType>(dyn_cast<DICompositeType>(md)->getBaseType());
      }
      else if (dyn_cast<DIDerivedType>(md)) {
        md = dyn_cast<DIType>(dyn_cast<DIDerivedType>(md)->getBaseType());
      }

      md->dump();
//      (*dyn_cast<DICompositeType>(md)->getBaseType()).dump();
//      dyn_cast<DIType>(dyn_cast<DICompositeType>(md)->getBaseType())->dump();
      ele_type = array_typet(
          create_array_type(dyn_cast<ArrayType>(type)->getArrayElementType(),
                            md),
          size);
      break;
    }
    case llvm::Type::TypeID::PointerTyID: {

      if (dyn_cast<DICompositeType>(md)) {
        md = dyn_cast<DIType>(dyn_cast<DICompositeType>(md)->getBaseType());
      }
      else if (dyn_cast<DIDerivedType>(md)) {
        md = dyn_cast<DIType>(dyn_cast<DIDerivedType>(md)->getBaseType());
      }

      typet ptr_type = create_pointer_type(
          dyn_cast<ArrayType>(type)->getArrayElementType(), md);
      ele_type = pointer_typet(ptr_type, config.ansi_c.pointer_width);
      break;
    }
    case llvm::Type::TypeID::VectorTyID: {
      errs() << "\nVector type NO ACTION!!!!";
      break;
    }
    case llvm::Type::TypeID::X86_MMXTyID: {
      errs() << "\n X86_MMX type NO ACTION!!!!";
      break;
    }
    case llvm::Type::TypeID::VoidTyID:
    case llvm::Type::TypeID::FunctionTyID:
    case llvm::Type::TypeID::TokenTyID:
    case llvm::Type::TypeID::LabelTyID:
    case llvm::Type::TypeID::MetadataTyID:
      errs() << "\ninvalid type for global variable";
  }
  return ele_type;
}

/*******************************************************************
 Function: symbol_creator::create_PointerTy

 Inputs:
 GV - reference to global variable in llvm module.
 name - name of the global variable

 Outputs: Object of symbolt.

 Purpose: Create apropriate goto symbol in symbol table corresponding to
 llvm global variable.

 \*******************************************************************/
symbolt symbol_creator::create_PointerTy(Type *type, MDNode *mdn) {
  mdn->dump();
  symbolt global_variable;
  global_variable.clear();
  if (dyn_cast<DIGlobalVariable>(mdn)) {
    global_variable.is_static_lifetime = true;
  }
  DIDerivedType *md = dyn_cast<DIDerivedType>(
      dyn_cast<DIVariable>(mdn)->getType());
  while (md->getTag() == dwarf::DW_TAG_typedef)
    md = dyn_cast<DIDerivedType>(md->getBaseType());
  typet ele_type = create_pointer_type(type, dyn_cast<DIType>(md));

  pointer_typet pt(ele_type, config.ansi_c.pointer_width);  /// TODO(Rasika) : set proper value.
  global_variable.type = pt;
  global_variable.location = locationt::get_location_global_variable(
      dyn_cast<DIVariable>(mdn));
  const irep_idt tmp_name = dyn_cast<DIVariable>(mdn)->getName().str();
  global_variable.base_name = tmp_name;
  return global_variable;
}

/*******************************************************************
 Function: symbol_creator::create_pointer_type

 Inputs:
 GV - reference to global variable in llvm module.
 md - pointer to DIDerivedType.

 Outputs: Object of struct_union_typet.

 Purpose: Create apropriate goto symbol typet corresponding to given
 llvm pointer type.

 \*******************************************************************/
typet symbol_creator::create_pointer_type(Type *type, llvm::DIType *md) {
  while (md->getTag() == dwarf::DW_TAG_typedef)
    md = dyn_cast<DIType>(dyn_cast<DIDerivedType>(md)->getBaseType());
  md->dump();
  while (md->getTag() == dwarf::DW_TAG_typedef)
    md = dyn_cast<DIType>(dyn_cast<DIDerivedType>(md)->getBaseType());
  typet ele_type;
  switch (dyn_cast<PointerType>(type)->getPointerElementType()->getTypeID()) {
    // 16-bit floating point type
    case llvm::Type::TypeID::HalfTyID: {
      ele_type = to_floatbv_type(bitvector_typet(ID_floatbv, 16));
      break;
    }
      // 32-bit floating point type
    case llvm::Type::TypeID::FloatTyID: {
      ele_type = to_floatbv_type(bitvector_typet(ID_floatbv, 32));
      break;
    }
      // 64-bit floating point type
    case llvm::Type::TypeID::DoubleTyID: {
      ele_type = to_floatbv_type(bitvector_typet(ID_floatbv, 64));
      break;
    }
      // 80-bit floating point type (X87)
    case llvm::Type::TypeID::X86_FP80TyID: {
      ele_type = to_floatbv_type(bitvector_typet(ID_floatbv, 80));
      break;
    }
      // 128-bit floating point type (112-bit mantissa)
    case llvm::Type::TypeID::FP128TyID: {
      ele_type = to_floatbv_type(bitvector_typet(ID_floatbv, 128));
      break;
    }
      // 128-bit floating point type (two 64-bits, PowerPC)
    case llvm::Type::TypeID::PPC_FP128TyID: {
      ele_type = to_floatbv_type(bitvector_typet(ID_floatbv, 128));
      break;
    }
    case llvm::Type::TypeID::IntegerTyID: {
//      if (dyn_cast<PointerType>(type)->getPointerElementType()
//          ->getIntegerBitWidth() == 1) {
//        ele_type = bool_typet();
//      }
//      else {
//        ele_type = unsignedbv_typet(
//            dyn_cast<PointerType>(type)->getPointerElementType()
//                ->getIntegerBitWidth());
//      }
      if (dyn_cast<PointerType>(type)->getPointerElementType()
          ->getIntegerBitWidth() == 1) {
        ele_type = bool_typet();
      }
      else {
//        ele_type = unsignedbv_typet(
//            dyn_cast<PointerType>(type)->getPointerElementType()
//                ->getIntegerBitWidth());
//        errs() << (md == NULL) << "\n";
        md->dump();
        int encoding;
//        if (dyn_cast<DIBasicType>(md)) {
//          encoding = dyn_cast<DIBasicType>(md)->getEncoding();
//        }
//        else if (dyn_cast<DIDerivedType>(md)) {
//          encoding = dyn_cast<DIBasicType>(
//              dyn_cast<DIDerivedType>(md)->getBaseType())->getEncoding();
//      }
//        while (!(dyn_cast<DIBasicType>(md))) {
//          if (dyn_cast<DIDerivedType>(md)) {
//            md = dyn_cast<DIType>(dyn_cast<DIDerivedType>(md)->getBaseType());
//          }
//          if (dyn_cast<DICompositeType>(md)) {
//            md = dyn_cast<DIType>(dyn_cast<DICompositeType>(md)->getBaseType());
//          }
//        }
//        encoding = dyn_cast<DIBasicType>(md)->getEncoding();
        encoding = get_encoding(md);

        switch (encoding) {
          case dwarf::DW_ATE_signed: {
            ele_type = signed_int_type();
            break;
          }
          case dwarf::DW_ATE_unsigned: {
            // case dwarf::DW_EH_PE_signed :
            ele_type = unsigned_int_type();
            break;
          }
          case dwarf::DW_ATE_signed_char: {
            // case dwarf::DW_EH_PE_signed :
            ele_type = signed_char_type();
            break;
          }
          case dwarf::DW_ATE_unsigned_char: {
            // case dwarf::DW_EH_PE_signed :
            ele_type = unsigned_char_type();
            break;
          }
          case -10: {
            ele_type = void_typet();
            break;
          }
          default: {
            ele_type = signedbv_typet(
                dyn_cast<PointerType>(type)->getPointerElementType()
                    ->getIntegerBitWidth());
            break;
          }
        }
      }
      break;
    }
    case llvm::Type::TypeID::StructTyID: {
      DIType * temp = md;
      while (!dyn_cast<DICompositeType>(temp))
        if (dyn_cast<DIDerivedType>(temp))
          temp = dyn_cast<DIType>(dyn_cast<DIDerivedType>(temp)->getBaseType());
        else
          assert(false && "Akash Struct type metadata not found!");
      ele_type = create_struct_union_type(
          (dyn_cast<PointerType>(type)->getPointerElementType()), temp);
      break;
    }
    case llvm::Type::TypeID::ArrayTyID: {
      errs() << "array in pointer";
      exprt size = from_integer(
          dyn_cast<ArrayType>(
              dyn_cast<PointerType>(type)->getPointerElementType())
              ->getNumElements(),
          size_type());

      if (dyn_cast<DICompositeType>(md)) {
        md = dyn_cast<DIType>(dyn_cast<DICompositeType>(md)->getBaseType());
      }
      else if (dyn_cast<DIDerivedType>(md)) {
        md = dyn_cast<DIType>(dyn_cast<DIDerivedType>(md)->getBaseType());
      }

      ele_type = array_typet(
          create_array_type(
              dyn_cast<PointerType>(type)->getPointerElementType(), md),
          size);
      break;
    }
    case llvm::Type::TypeID::PointerTyID: {

      if (dyn_cast<DICompositeType>(md)) {
        md = dyn_cast<DIType>(dyn_cast<DICompositeType>(md)->getBaseType());
      }
      else if (dyn_cast<DIDerivedType>(md)) {
        md = dyn_cast<DIType>(dyn_cast<DIDerivedType>(md)->getBaseType());
      }

      typet ptr_type = create_pointer_type(
          dyn_cast<PointerType>(type)->getPointerElementType(), md);
      ele_type = pointer_typet(ptr_type, config.ansi_c.pointer_width);
      break;
    }
    case llvm::Type::TypeID::VectorTyID: {
      errs() << "\nVector type NO ACTION!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!";
      break;
    }
    case llvm::Type::TypeID::X86_MMXTyID: {
      break;
    }
    case llvm::Type::TypeID::VoidTyID: {
      ele_type = void_typet();
      break;
    }
    case llvm::Type::TypeID::FunctionTyID: {
      if (dyn_cast<DICompositeType>(md)) {
        md = dyn_cast<DIType>(dyn_cast<DICompositeType>(md)->getBaseType());
      }
      else if (dyn_cast<DIDerivedType>(md)) {
        md = dyn_cast<DIType>(dyn_cast<DIDerivedType>(md)->getBaseType());
      }
      ele_type = create_Function_Ptr(
          dyn_cast<FunctionType>(type->getPointerElementType()), md);
      break;
    }
    case llvm::Type::TypeID::TokenTyID:
    case llvm::Type::TypeID::LabelTyID:
    case llvm::Type::TypeID::MetadataTyID:
      errs() << "\ninvalid type for global variable";
  }
  return ele_type;
}

/*******************************************************************
 Function: symbol_creator::create_VectorTy

 Inputs:
 GV - reference to global variable in llvm module.
 name - name of the global variable

 Outputs: Object of symbolt.

 Purpose: Create apropriate goto symbol in symbol table corresponding to
 llvm global variable.

 \*******************************************************************/
symbolt symbol_creator::create_VectorTy(Type *type, MDNode *mdn) {
  symbolt global_variable;
  global_variable.clear();
  if (dyn_cast<DIGlobalVariable>(mdn)) {
    global_variable.is_static_lifetime = true;
  }
  global_variable.location = locationt::get_location_global_variable(
      dyn_cast<DIVariable>(mdn));
  const irep_idt tmp_name = dyn_cast<DIVariable>(mdn)->getName().str();
  global_variable.base_name = tmp_name;
  return global_variable;
}

/*******************************************************************
 Function: symbol_creator::create_VoidTy

 Inputs:
 GV - reference to global variable in llvm module.
 name - name of the global variable

 Outputs: Object of symbolt.

 Purpose: Create apropriate goto symbol in symbol table corresponding to
 llvm global variable.

 \*******************************************************************/
symbolt symbol_creator::create_VoidTy(Type *type, MDNode *mdn) {
  symbolt global_variable;
  global_variable.clear();
  if (dyn_cast<DIGlobalVariable>(mdn)) {
    global_variable.is_static_lifetime = true;
  }
  global_variable.type = void_typet();
  global_variable.location = locationt::get_location_global_variable(
      dyn_cast<DIVariable>(mdn));
  const irep_idt tmp_name = dyn_cast<DIVariable>(mdn)->getName().str();
  global_variable.base_name = tmp_name;
  const irep_idt tmp_bname = "tid";
  global_variable.base_name = tmp_bname;
  global_variable.mode = ID_C;
  return global_variable;
}

typet symbol_creator::create_Function_Ptr(FunctionType *ft, const DIType *mdn) {
  while (mdn->getTag() == dwarf::DW_TAG_typedef)
    mdn = dyn_cast<DIType>(dyn_cast<DIDerivedType>(mdn)->getBaseType());
  code_typet ct = code_typet();
  code_typet::parameterst para;
  const DISubroutineType *md;
  if (dyn_cast<DISubroutineType>(mdn)) {
    md = dyn_cast<DISubroutineType>(mdn);
  }
  unsigned int i = 1;
  for (auto it = ft->params().begin(); it < ft->params().end(); it++) {
    DIType *t = dyn_cast<DIType>(&*md->getTypeArray()[i]);
    typet tt = create_type(*it, t);
    i++;
    code_typet::parametert p(tt);
//    p.set_identifier(F.getName().str() + "::" + arg->getName().str());
    para.push_back(p);
    assert(tt.id() != irep_idt());
  }
  ct.parameters() = para;
  if (&*md->getTypeArray()[0] != NULL) {
    DIType *mdn = dyn_cast<DIType>(&*md->getTypeArray()[0]);
    mdn = dyn_cast<DIType>(&*md->getTypeArray()[0]);
    ft->getReturnType();
    DIType *ditype = dyn_cast<DIType>(mdn);
    ct.return_type() = create_type(ft->getReturnType(), ditype);
  }
  else {
    ct.return_type() = void_typet();
  }

  return ct;
}

/*******************************************************************
 Function: symbol_creator::create_type

 Inputs:
 bj - .

 Outputs: .

 Purpose: .

 \*******************************************************************/
typet symbol_creator::create_type(Type *type, DIType *mdn) {
  while (mdn->getTag() == dwarf::DW_TAG_typedef)
    mdn = dyn_cast<DIType>(dyn_cast<DIDerivedType>(mdn)->getBaseType());
  typet ele_type;
  switch (type->getTypeID()) {
    // 16-bit floating point type
    case llvm::Type::TypeID::HalfTyID: {
      ele_type = to_floatbv_type(bitvector_typet(ID_floatbv, 16));
      break;
    }
      // 32-bit floating point type
    case llvm::Type::TypeID::FloatTyID: {
      ele_type = to_floatbv_type(bitvector_typet(ID_floatbv, 32));
      break;
    }
      // 64-bit floating point type
    case llvm::Type::TypeID::DoubleTyID: {
      ele_type = to_floatbv_type(bitvector_typet(ID_floatbv, 64));
      break;
    }
      // 80-bit floating point type (X87)
    case llvm::Type::TypeID::X86_FP80TyID: {
      ele_type = to_floatbv_type(bitvector_typet(ID_floatbv, 80));
      break;
    }
      // 128-bit floating point type (112-bit mantissa)
    case llvm::Type::TypeID::FP128TyID: {
      ele_type = to_floatbv_type(bitvector_typet(ID_floatbv, 128));
      break;
    }
      // 128-bit floating point type (two 64-bits, PowerPC)
    case llvm::Type::TypeID::PPC_FP128TyID: {
      ele_type = to_floatbv_type(bitvector_typet(ID_floatbv, 128));
      break;
    }
    case llvm::Type::TypeID::IntegerTyID: {
      if (type->getIntegerBitWidth() == 1) {
        ele_type = bool_typet();
      }
      else if (type->getIntegerBitWidth() == 8) {
        ele_type = signed_char_type();
      }
      else if (type->getIntegerBitWidth() == 64) {
        ele_type = signed_long_int_type();
      }
      else {
        ele_type = signed_int_type();
      }
//      while (dyn_cast<DIDerivedType>(type1)) {
//        type1 = dyn_cast<DIType>(
//            &(*(dyn_cast<DIDerivedType>(type1)->getBaseType())));
//      }
      int encoding = get_encoding(mdn);
      switch (encoding) {
        case dwarf::DW_ATE_signed: {
          ele_type = signed_int_type();
          break;
        }
        case dwarf::DW_ATE_signed_char: {
          // case dwarf::DW_EH_PE_signed :
//          ele_type = signedbv_typet(type->getIntegerBitWidth());
          ele_type = signed_char_type();
          break;
        }
        case dwarf::DW_ATE_unsigned_char: {
          // case dwarf::DW_EH_PE_signed :
//          ele_type = signedbv_typet(type->getIntegerBitWidth());
          ele_type = unsigned_char_type();
          break;
        }
        case dwarf::DW_ATE_unsigned: {
          // case dwarf::DW_EH_PE_signed :
          ele_type = unsigned_int_type();
          break;
        }
        case -10: {
          ele_type = void_typet();
          break;
        }
        default: {
          ele_type = signedbv_typet(type->getIntegerBitWidth());
          break;
        }
      }
      // if(type->getIntegerBitWidth() == 1)
      // {
      // ele_type = bool_typet();
      // }
      // else
      // {
      // ele_type = unsignedbv_typet(type->getIntegerBitWidth());
      // }
      break;
    }
    case llvm::Type::TypeID::StructTyID: {
      errs() << "\n struct no action.................";
      // ele_type = create_struct_union_type(
      //   (dyn_cast<PointerType>(type)->getPointerElementType()),
      //   dyn_cast<DICompositeType>(dyn_cast<DIDerivedType>(md)->getBaseType()));
      break;
    }
    case llvm::Type::TypeID::ArrayTyID: {
      errs() << "\n array no action.................";
      // exprt size = from_integer(
      //   dyn_cast<ArrayType>(
      //     dyn_cast<PointerType>(type)->getPointerElementType())
      //   ->getNumElements(),
      //   signedbv_typet(32));
      // ele_type = array_typet(
      //   create_array_type(
      //     dyn_cast<PointerType>(type)->getPointerElementType(),
      //     dyn_cast<DICompositeType>(
      //       dyn_cast<DICompositeType>(md)->getBaseType())),
      //   size);
      break;
    }
    case llvm::Type::TypeID::PointerTyID: {
      errs() << "\n pointer no action.................";
      typet ptr_sub_type = create_pointer_type(type, mdn);
      ele_type = pointer_typet(ptr_sub_type, config.ansi_c.pointer_width);
      break;
    }
    case llvm::Type::TypeID::VectorTyID: {
      errs() << "\nVector type NO ACTION!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!";
      break;
    }
    case llvm::Type::TypeID::X86_MMXTyID: {
      break;
    }
    case llvm::Type::TypeID::VoidTyID: {
      // typet void_type = create_void_typet();
      ele_type = void_typet();
      errs() << "void_typet";
      break;
    }
    case llvm::Type::TypeID::FunctionTyID:
    case llvm::Type::TypeID::TokenTyID:
    case llvm::Type::TypeID::LabelTyID:
    case llvm::Type::TypeID::MetadataTyID:
      errs() << "\ninvalid type for global variable";
  }
  return ele_type;
}

/*******************************************************************
 Function: symbol_creator::create_type

 Inputs:
 bj - .

 Outputs: .

 Purpose: .

 \*******************************************************************/
typet symbol_creator::create_type(Type *type, bool is_void_type) {
  typet ele_type;
  switch (type->getTypeID()) {
    // 16-bit floating point type
    case llvm::Type::TypeID::HalfTyID: {
      ele_type = to_floatbv_type(bitvector_typet(ID_floatbv, 16));
      break;
    }
      // 32-bit floating point type
    case llvm::Type::TypeID::FloatTyID: {
      ele_type = to_floatbv_type(bitvector_typet(ID_floatbv, 32));
      break;
    }
      // 64-bit floating point type
    case llvm::Type::TypeID::DoubleTyID: {
      ele_type = to_floatbv_type(bitvector_typet(ID_floatbv, 64));
      break;
    }
      // 80-bit floating point type (X87)
    case llvm::Type::TypeID::X86_FP80TyID: {
      ele_type = to_floatbv_type(bitvector_typet(ID_floatbv, 80));
      break;
    }
      // 128-bit floating point type (112-bit mantissa)
    case llvm::Type::TypeID::FP128TyID: {
      ele_type = to_floatbv_type(bitvector_typet(ID_floatbv, 128));
      break;
    }
      // 128-bit floating point type (two 64-bits, PowerPC)
    case llvm::Type::TypeID::PPC_FP128TyID: {
      ele_type = to_floatbv_type(bitvector_typet(ID_floatbv, 128));
      break;
    }
    case llvm::Type::TypeID::IntegerTyID: {
      if (type->getIntegerBitWidth() == 1) {
        ele_type = bool_typet();
      }
      else if (type->getIntegerBitWidth() == 8 && is_void_type) {
        ele_type = void_typet();
      }
      else if (type->getIntegerBitWidth() == 8) {
        ele_type = signed_char_type();
      }
      else {
        ele_type = signed_int_type();
      }
      break;
    }
    case llvm::Type::TypeID::StructTyID: {
      static long akash_name = 0;
      struct_union_typet sut(ID_struct);
      struct_union_typet::componentst &components = sut.components();
      for (StructType::element_iterator e = dyn_cast<StructType>(type)
          ->element_begin(); e != dyn_cast<StructType>(type)->element_end();
          e++) {
        // (*e)->dump();
        // assert(false);
        struct_union_typet::componentt component(
            ("a" + std::to_string(akash_name)).c_str(), create_type(*e));
        components.push_back(component);
        akash_name++;
      }
      ele_type = sut;
      // errs() << "\n struct no action.................";
      break;
    }
    case llvm::Type::TypeID::ArrayTyID: {
      errs() << "\n array no action.................";
      break;
    }
    case llvm::Type::TypeID::PointerTyID: {
      ele_type = pointer_typet(
          create_type(dyn_cast<PointerType>(type)->getPointerElementType(),
                      is_void_type),
          config.ansi_c.pointer_width);
      break;
    }
    case llvm::Type::TypeID::VectorTyID: {
      errs() << "\nVector type NO ACTION!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!";
      break;
    }
    case llvm::Type::TypeID::X86_MMXTyID: {
      break;
    }
    case llvm::Type::TypeID::VoidTyID: {
      ele_type = void_typet();
      errs() << "void_typet";
      break;
    }
    case llvm::Type::TypeID::FunctionTyID:
    case llvm::Type::TypeID::TokenTyID:
    case llvm::Type::TypeID::LabelTyID:
    case llvm::Type::TypeID::MetadataTyID:
      errs() << "\ninvalid type for global variable";
  }
  return ele_type;
}

/*******************************************************************
 Function: symbol_creator::create_FunctionTy

 Inputs:
 GV - reference to global variable in llvm module.
 name - name of the global variable

 Outputs: Object of symbolt.

 Purpose: Create apropriate goto symbol in symbol table corresponding to
 llvm global variable.

 \*******************************************************************/
symbolt symbol_creator::create_FunctionTy(Type *type, const Function &F) {
  errs() << "\n FunctionType :\n" << F.getName() << "\n";
  FunctionType *ft = dyn_cast<FunctionType>(type);
  symbolt funct;
  funct.clear();
  funct.is_thread_local = false;
// const irep_idt funct_bname = "funct";
// const irep_idt funct_name = "funct";
  funct.mode = ID_C;
// funct.name = funct_name;
// funct.base_name = funct_bname;
  code_typet ct = code_typet();
  code_typet::parameterst para;
// code_typet::parametert p1(unsignedbv_typet(32));
// para.push_back(p1);
  if (F.hasMetadata()) {
    DISubroutineType *md =
        (dyn_cast<DISubprogram>(F.getSubprogram()))->getType();
    // md->dump();

    // errs() << md->size() << "\n\n";
    // if(md->getTypeArray()->getNumOperands() > 1)
    // {
    //   md->dump();
    //   md->getTypeArray()->dump();

    //   mdn->dump();
    //   errs() << "=============\n";
    // }
    // errs() << dyn_cast<DIBasicType>(dyn_cast<DISubroutineType>(md->getType())->getTypeArray()[0])->getEncoding() << "\n";
    // switch(dyn_cast<DIBasicType>(dyn_cast<DISubroutineType>(md->getType())->getTypeArray()[0])->getEncoding())
    // {
    //   case dwarf::DW_ATE_signed :
    //   case dwarf::DW_ATE_signed_char :
    //   // case dwarf::DW_EH_PE_signed :
    //     ft->getReturnType()->dump();
    //     errs() << "signed type found!!!\n";
    //     ct.return_type() = signedbv_typet(
    //       ft->getReturnType()->getIntegerBitWidth());
    //     break;
    // }
    auto arg = F.arg_begin();
    unsigned int i = 1;
    // errs() << F.getName() << " = ";
    for (auto it = ft->params().begin(); it < ft->params().end(); it++) {
      // errs() << "arg ";
      typet tt;
      if (i < md->getTypeArray().size()) {
        DIType *t = dyn_cast<DIType>(&*md->getTypeArray()[i]);
        if (t->getTag() == dwarf::DW_TAG_structure_type) {
          tt = create_type(*it);
        }
        else
          tt = create_type(*it, t);
      }
      else
        tt = create_type(*it);
      i++;
      code_typet::parametert p(tt);
      p.set_identifier(F.getName().str() + "::" + arg->getName().str());
      para.push_back(p);
      // errs() << arg->getName() << ", ";
      arg++;
      // (*it)->dump();
      // set_identifier
      assert(p.get_identifier() != irep_idt());
      assert(tt.id() != irep_idt());
      // ft->getParamType(0)->dump();
      // ft->getParamType(i)->getMetadata()->dump();
    }
    // errs() << "\n";
    ct.parameters() = para;
    if (&*md->getTypeArray()[0] != NULL) {
      DIType *mdn = dyn_cast<DIType>(&*md->getTypeArray()[0]);
      ft->getReturnType();
      while (mdn->getTag() == dwarf::DW_TAG_typedef)
        mdn = dyn_cast<DIType>(dyn_cast<DIDerivedType>(mdn)->getBaseType());
      ct.return_type() = create_type(ft->getReturnType(), mdn);
    }
    else {
      ct.return_type() = void_typet();
    }
  }
// static_cast<unsignedbv_typet &>(rt);
  funct.type = ct;

// funct.location = locationt::get_location_funct(
// dyn_cast<DIVariable>(mdn));
  return funct;
}

/*******************************************************************
 Function: symbol_creator::create_TokenTy

 Inputs:
 GV - reference to global variable in llvm module.
 name - name of the global variable

 Outputs: Object of symbolt.

 Purpose: Create apropriate goto symbol in symbol table corresponding to
 llvm global variable.

 \*******************************************************************/
symbolt symbol_creator::create_TokenTy(Type *type, MDNode *mdn) {
  symbolt global_variable;
  global_variable.clear();
  if (dyn_cast<DIGlobalVariable>(mdn)) {
    global_variable.is_static_lifetime = true;
  }
  global_variable.location = locationt::get_location_global_variable(
      dyn_cast<DIVariable>(mdn));
  const irep_idt tmp_name = dyn_cast<DIVariable>(mdn)->getName().str();
  global_variable.base_name = tmp_name;
  return global_variable;
}

/*******************************************************************
 Function: symbol_creator::create_LabelTy

 Inputs:
 GV - reference to global variable in llvm module.
 name - name of the global variable

 Outputs: Object of symbolt.

 Purpose: Create apropriate goto symbol in symbol table corresponding to
 llvm global variable.

 \*******************************************************************/
symbolt symbol_creator::create_LabelTy(Type *type, MDNode *mdn) {
  symbolt global_variable;
  global_variable.clear();
  if (dyn_cast<DIGlobalVariable>(mdn)) {
    global_variable.is_static_lifetime = true;
  }
  global_variable.location = locationt::get_location_global_variable(
      dyn_cast<DIVariable>(mdn));
  const irep_idt tmp_name = dyn_cast<DIVariable>(mdn)->getName().str();
  global_variable.base_name = tmp_name;
  return global_variable;
}

/*******************************************************************
 Function: symbol_creator::create_MetadataTy

 Inputs:
 GV - reference to global variable in llvm module.
 name - name of the global variable

 Outputs: Object of symbolt.

 Purpose: Create apropriate goto symbol in symbol table corresponding to
 llvm global variable.

 \*******************************************************************/
symbolt symbol_creator::create_MetadataTy(Type *type, MDNode *mdn) {
  symbolt global_variable;
  global_variable.clear();
  if (dyn_cast<DIGlobalVariable>(mdn)) {
    global_variable.is_static_lifetime = true;
  }
  global_variable.location = locationt::get_location_global_variable(
      dyn_cast<DIVariable>(mdn));
  const irep_idt tmp_name = dyn_cast<DIVariable>(mdn)->getName().str();
  global_variable.base_name = tmp_name;
  return global_variable;
}
