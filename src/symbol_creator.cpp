/* Copyright


*/
#include "symbol_creator.h"
#include "locationt.h"

#include "llvm/Support/raw_ostream.h"

#include "util/arith_tools.h"
#include "util/std_expr.h"

// Language mode is temporarily set to 'C'.
// TODO(Rasika) : set the appropriate width of array size.
// TODO(Rasika) : Initial value of symbol.
// TODO(Rasika) : The unique identifier.
// TODO(Rasika) : Name of module the symbol belongs to.
// TODO(Rasika) : Base (non-scoped) name.
// TODO(Rasika) : Language-specifname.
// TODO(Rasika) : 128-bit floating point type (112-bit mantissa) FP128Ty
// TODO(Rasika) : 128-bit floating point type (two 64-bits, PowerPC) PPC_FP128Ty

/*******************************************************************\

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
  global_variable.type = bvt;
  global_variable.location = locationt::get_location_global_variable(mdn);
  const irep_idt tmp_name = dyn_cast<DIVariable>(mdn)->getName().str();
  global_variable.name = tmp_name;
  global_variable.mode = ID_C;
  return global_variable;
}

/*******************************************************************\

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
  bitvector_typet bvt(ID_floatbv, 32);
  global_variable.type = bvt;
  global_variable.location = locationt::get_location_global_variable(mdn);
  const irep_idt tmp_name = dyn_cast<DIVariable>(mdn)->getName().str();
  global_variable.name = tmp_name;
  global_variable.mode = ID_C;
  return global_variable;
}

/*******************************************************************\

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
  bitvector_typet bvt(ID_floatbv, 64);
  global_variable.type = bvt;
  global_variable.location = locationt::get_location_global_variable(mdn);
  const irep_idt tmp_name = dyn_cast<DIVariable>(mdn)->getName().str();
  global_variable.name = tmp_name;
  global_variable.mode = ID_C;
  return global_variable;
}

/*******************************************************************\

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
  global_variable.type = bvt;
  global_variable.location = locationt::get_location_global_variable(mdn);
  const irep_idt tmp_name = dyn_cast<DIVariable>(mdn)->getName().str();
  global_variable.name = tmp_name;
  global_variable.mode = ID_C;
  return global_variable;
}

/*******************************************************************\

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
  global_variable.type = bvt;
  global_variable.location = locationt::get_location_global_variable(mdn);
  const irep_idt tmp_name = dyn_cast<DIVariable>(mdn)->getName().str();
  global_variable.name = tmp_name;
  global_variable.mode = ID_C;
  return global_variable;
}

/*******************************************************************\

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
  global_variable.type = bvt;
  global_variable.location = locationt::get_location_global_variable(mdn);
  const irep_idt tmp_name = dyn_cast<DIVariable>(mdn)->getName().str();
  global_variable.name = tmp_name;
  global_variable.mode = ID_C;
  return global_variable;
}

/*******************************************************************\

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
  global_variable.name = tmp_name;
  if (dyn_cast<DIGlobalVariable>(mdn)) {
    global_variable.is_static_lifetime = true;
  }
  return global_variable;
}

/*******************************************************************\

  Function: symbol_creator::create_IntegerTy

  Inputs:
   GV - reference to global variable in llvm module.
   name - name of the global variable

  Outputs: Object of symbolt.

  Purpose: Create bool_typet or unsignedbv_typet symbol.

\*******************************************************************/
symbolt symbol_creator::create_IntegerTy(Type *type, MDNode *mdn) {
  symbolt global_variable;
  global_variable.clear();
  if (dyn_cast<DIGlobalVariable>(mdn)) {
    global_variable.is_static_lifetime = true;
  }
  // type->dump();
  // errs() << "\nhi1";
  if (type->getIntegerBitWidth() == 1) {
  global_variable.type = bool_typet();
  } else {
    // errs() << "\n hi2 \n";
  global_variable.type = unsignedbv_typet(
    type->getIntegerBitWidth());
  global_variable.value = from_integer(0,
    global_variable.type);
  }
  // mdn->dump();
  if (dyn_cast<DIGlobalVariable>(mdn) != NULL) {
    global_variable.location = locationt::get_location_global_variable(mdn);
    const irep_idt tmp_name = dyn_cast<DIGlobalVariable>(mdn)->getName().str();
    global_variable.name = tmp_name;
  } else if (dyn_cast<DILocalVariable>(mdn) != NULL) {
    global_variable.location = locationt::get_location_global_variable(mdn);
    const irep_idt tmp_name = dyn_cast<DILocalVariable>(mdn)->getName().str();
    global_variable.name = tmp_name;
  }
  global_variable.mode = ID_C;
  return global_variable;
}

/*******************************************************************\

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
  struct_union_typet sut(ID_struct);
  struct_union_typet::componentst &components = sut.components();
  DICompositeType *md = dyn_cast<DICompositeType>(
  dyn_cast<DIVariable>(mdn)->getType());
  DINodeArray Fields = md->getElements();
  int i = 0;
  for (StructType::element_iterator e =
      dyn_cast<StructType>(type)->element_begin();
    e != dyn_cast<StructType>(type)->element_end();
    e++
    ) {
    irep_idt ele_name = dyn_cast<DIType>(Fields[i])->getName().str();
    switch ((*e)->getTypeID()) {
      case llvm::Type::TypeID::HalfTyID : {
      bitvector_typet bvt(ID_floatbv, 16);
      struct_union_typet::componentt component(ele_name, bvt);
      components.push_back(component);
      break;
      }
      case llvm::Type::TypeID::FloatTyID : {
      bitvector_typet bvt(ID_floatbv, 32);
      struct_union_typet::componentt component(ele_name, bvt);
      components.push_back(component);
      break;
      }
      case llvm::Type::TypeID::DoubleTyID : {
      bitvector_typet bvt(ID_floatbv, 64);
      struct_union_typet::componentt component(ele_name, bvt);
      components.push_back(component);
      break;
      }
      case llvm::Type::TypeID::X86_FP80TyID : {
      bitvector_typet bvt(ID_floatbv, 80);
      struct_union_typet::componentt component(ele_name, bvt);
      components.push_back(component);
      break;
      }
      case llvm::Type::TypeID::FP128TyID : {
      bitvector_typet bvt(ID_floatbv, 128);
      struct_union_typet::componentt component(ele_name, bvt);
      components.push_back(component);
      break;
      }
      case llvm::Type::TypeID::PPC_FP128TyID : {
      bitvector_typet bvt(ID_floatbv, 128);
      struct_union_typet::componentt component(ele_name, bvt);
      components.push_back(component);
      break;
      }
      case llvm::Type::TypeID::IntegerTyID : {
      if ((*e)->getIntegerBitWidth() == 1) {
        struct_union_typet::componentt component(ele_name, bool_typet());
        components.push_back(component);
      } else {
        struct_union_typet::componentt component(ele_name,
        unsignedbv_typet((*e)->getIntegerBitWidth()));
        components.push_back(component);
      }
      break;
      }
      case llvm::Type::TypeID::StructTyID : {
      MDNode *ele_type;
      if (dyn_cast<DIDerivedType>(Fields[i])) {
        ele_type = dyn_cast<MDNode>(
        dyn_cast<DIDerivedType>(Fields[i])->getBaseType());
      } else {
        errs() << "\n Unhandled datatype in :\n";
        Fields[i]->dump();
      }
      struct_union_typet::componentt component(ele_name,
        create_struct_union_type(*e,
        dyn_cast<DICompositeType>(ele_type)));
      components.push_back(component);
      break;
      }
      case llvm::Type::TypeID::ArrayTyID : {
      Type *mew = *e;
      dyn_cast<ArrayType>(mew);
      exprt size = from_integer(
        dyn_cast<ArrayType>(*e)->getNumElements(), signedbv_typet(32));
      typet arrt = create_array_type(*e,
        dyn_cast<DICompositeType>(
          dyn_cast<DIDerivedType>(Fields[i])->getBaseType()));
      struct_union_typet::componentt component(ele_name,
        array_typet(arrt, size));
      components.push_back(component);
      break;
      }
      case llvm::Type::TypeID::PointerTyID : {
      typet ptr_type = create_pointer_type(*e,
        dyn_cast<DIDerivedType>(
          dyn_cast<DIDerivedType>(Fields[i])->getBaseType()));
      pointer_typet pt(ptr_type, 17);
      struct_union_typet::componentt component(ele_name, pt);
      components.push_back(component);
      break;
      }
      case llvm::Type::TypeID::VectorTyID : {
      errs() << "VectorTyID NO ACTION TAKEN\n";
      // struct_union_typet::componentt component(ele_name, _ID);
      // components.push_back(component);
      break;
      }
      case llvm::Type::TypeID::X86_MMXTyID : {
      errs() << "X86_MMXTyID NO ACTION TAKEN\n";
      // struct_union_typet::componentt component(ele_name, _ID);
      // components.push_back(component);
      break;
      }
      case llvm::Type::TypeID::VoidTyID : {
      errs() << "VoidTyID NO ACTION TAKEN\n";
      // struct_union_typet::componentt component(ele_name, _ID);
      // components.push_back(component);
      break;
      }
      case llvm::Type::TypeID::FunctionTyID : {
      errs() << "FunctionTyID NO ACTION TAKEN\n";
      // struct_union_typet::componentt component(ele_name, _ID);
      // components.push_back(component);
      break;
      }
      case llvm::Type::TypeID::TokenTyID : {
      errs() << "TokenTyID NO ACTION TAKEN\n";
      // struct_union_typet::componentt component(ele_name, _ID);
      // components.push_back(component);
      break;
      }
      case llvm::Type::TypeID::LabelTyID : {
      errs() << "LabelTyID NO ACTION TAKEN\n";
      // struct_union_typet::componentt component(ele_name, _ID);
      // components.push_back(component);
      break;
      }
      case llvm::Type::TypeID::MetadataTyID : {
      errs() << "MetadataTyID NO ACTION TAKEN\n";
      // struct_union_typet::componentt component(ele_name, _ID);
      // components.push_back(component);
      break;
      }
      default : break;
    }
    i++;
  }

  global_variable.type = sut;
  global_variable.location = locationt::get_location_global_variable(
  dyn_cast<DIVariable>(mdn));
  const irep_idt tmp_name = dyn_cast<DIVariable>(mdn)->getName().str();
  global_variable.name = tmp_name;
  global_variable.mode = ID_C;
  return global_variable;
}

/*******************************************************************\

  Function: symbol_creator::create_struct_union_type

  Inputs:
   GV - reference to global variable in llvm module.
   md - pointer to DICompositeType.

  Outputs: Object of struct_union_typet.

  Purpose: Create apropriate goto symbol typet corresponding to given
       llvm struct type.

\*******************************************************************/
struct_union_typet symbol_creator::create_struct_union_type(Type *type,
  const llvm::DICompositeType *md) {
  struct_union_typet sut(ID_struct);
  struct_union_typet::componentst &components = sut.components();
  DINodeArray Fields = md->getElements();
  int i = 0;
  for (StructType::element_iterator e =
      dyn_cast<StructType>(type)->element_begin();
    e != dyn_cast<StructType>(type)->element_end();
    e++
    ) {
    irep_idt ele_name = dyn_cast<DIDerivedType>(Fields[i])->getName().str();
    switch ((*e)->getTypeID()) {
      case llvm::Type::TypeID::HalfTyID : {
      bitvector_typet bvt(ID_floatbv, 16);
      struct_union_typet::componentt component(ele_name, bvt);
      components.push_back(component);
      break;
      }
      case llvm::Type::TypeID::FloatTyID : {
      bitvector_typet bvt(ID_floatbv, 32);
      struct_union_typet::componentt component(ele_name, bvt);
      components.push_back(component);
      break;
      }
      case llvm::Type::TypeID::DoubleTyID : {
      bitvector_typet bvt(ID_floatbv, 64);
      struct_union_typet::componentt component(ele_name, bvt);
      components.push_back(component);
      break;
      }
      case llvm::Type::TypeID::X86_FP80TyID : {
      bitvector_typet bvt(ID_floatbv, 80);
      struct_union_typet::componentt component(ele_name, bvt);
      components.push_back(component);
      break;
      }
      case llvm::Type::TypeID::FP128TyID : {
      bitvector_typet bvt(ID_floatbv, 128);
      struct_union_typet::componentt component(ele_name, bvt);
      components.push_back(component);
      break;
      }
      case llvm::Type::TypeID::PPC_FP128TyID : {
      bitvector_typet bvt(ID_floatbv, 128);
      struct_union_typet::componentt component(ele_name, bvt);
      components.push_back(component);
      break;
      }
      case llvm::Type::TypeID::IntegerTyID : {
      if ((*e)->getIntegerBitWidth() == 1) {
        struct_union_typet::componentt component(ele_name, bool_typet());
        components.push_back(component);
      } else {
        struct_union_typet::componentt component(ele_name,
        unsignedbv_typet((*e)->getIntegerBitWidth()));
        components.push_back(component);
      }
      break;
      }
      case llvm::Type::TypeID::StructTyID : {
      MDNode *ele_type;
      if (dyn_cast<DIDerivedType>(Fields[i])) {
        ele_type = dyn_cast<MDNode>(
        dyn_cast<DIDerivedType>(Fields[i])->getBaseType());
      } else {
        errs() << "\n Unhandled datatype in :\n";
        Fields[i]->dump();
      }
      struct_union_typet::componentt component(ele_name,
        create_struct_union_type(*e,
        dyn_cast<DICompositeType>(ele_type)));
      components.push_back(component);
      break;
      }
      case llvm::Type::TypeID::ArrayTyID : {
      struct_union_typet::componentt component(
        ele_name,
        create_array_type(*e,
          dyn_cast<DICompositeType>(
            dyn_cast<DIDerivedType>(Fields[i])->getBaseType())));
      components.push_back(component);
      break;
      }
      case llvm::Type::TypeID::PointerTyID : {
      typet ptr_type = create_pointer_type(*e,
        dyn_cast<DIDerivedType>(
          dyn_cast<DIDerivedType>(Fields[i])->getBaseType()));
      pointer_typet pt(ptr_type, 27);
      struct_union_typet::componentt component(ele_name, pt);
      components.push_back(component);
      break;
      }
      case llvm::Type::TypeID::VectorTyID : {
      errs() << "VectorTyID NO ACTION TAKEN\n";
      // struct_union_typet::componentt component(ele_name, _ID);
      // components.push_back(component);
      break;
      }
      case llvm::Type::TypeID::X86_MMXTyID : {
      errs() << "X86_MMXTyID NO ACTION TAKEN\n";
      // struct_union_typet::componentt component(ele_name, _ID);
      // components.push_back(component);
      break;
      }
      case llvm::Type::TypeID::VoidTyID : {
      errs() << "VoidTyID NO ACTION TAKEN\n";
      // struct_union_typet::componentt component(ele_name, _ID);
      // components.push_back(component);
      break;
      }
      case llvm::Type::TypeID::FunctionTyID : {
      errs() << "FunctionTyID NO ACTION TAKEN\n";
      // struct_union_typet::componentt component(ele_name, _ID);
      // components.push_back(component);
      break;
      }
      case llvm::Type::TypeID::TokenTyID : {
      errs() << "TokenTyID NO ACTION TAKEN\n";
      // struct_union_typet::componentt component(ele_name, _ID);
      // components.push_back(component);
      break;
      }
      case llvm::Type::TypeID::LabelTyID : {
      errs() << "LabelTyID NO ACTION TAKEN\n";
      // struct_union_typet::componentt component(ele_name, _ID);
      // components.push_back(component);
      break;
      }
      case llvm::Type::TypeID::MetadataTyID : {
      errs() << "MetadataTyID NO ACTION TAKEN\n";
      // struct_union_typet::componentt component(ele_name, _ID);
      // components.push_back(component);
      break;
      }
      default : break;
    }
    i++;
  }
  return sut;
}

/*******************************************************************\

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
  exprt size = from_integer(
    dyn_cast<ArrayType>(type)->getNumElements(),
    signedbv_typet(19));
  DICompositeType *md = dyn_cast<DICompositeType>(
  dyn_cast<DIVariable>(mdn)->getType());
  array_typet arrt(create_array_type(type, md), size);
  global_variable.type = arrt;
  global_variable.location = locationt::get_location_global_variable(
  dyn_cast<DIVariable>(mdn));
  const irep_idt tmp_name = dyn_cast<DIVariable>(mdn)->getName().str();
  global_variable.name = tmp_name;
  global_variable.mode = ID_C;
  return global_variable;
}

/*******************************************************************\

  Function: symbol_creator::create_array_type

  Inputs:
   GV - reference to global variable in llvm module.
   md - pointer to DICompositeType.

  Outputs: Object of struct_union_typet.

  Purpose: Create apropriate goto symbol typet corresponding to given
       llvm array type.

\*******************************************************************/
typet symbol_creator::create_array_type(Type *type,
  const llvm::DICompositeType *md) {
  typet ele_type;
  switch (dyn_cast<ArrayType>(type)->getArrayElementType()->getTypeID()) {
  // 16-bit floating point type
  case llvm::Type::TypeID::HalfTyID : {
    ele_type = bitvector_typet(ID_floatbv, 16);
  }
  // 32-bit floating point type
  case llvm::Type::TypeID::FloatTyID : {
    ele_type = bitvector_typet(ID_floatbv, 32);
    break;
  }
  // 64-bit floating point type
  case llvm::Type::TypeID::DoubleTyID : {
    ele_type = bitvector_typet(ID_floatbv, 64);
    break;
  }
  // 80-bit floating point type (X87)
  case llvm::Type::TypeID::X86_FP80TyID : {
    ele_type = bitvector_typet(ID_floatbv, 80);
    break;
  }
  // 128-bit floating point type (112-bit mantissa)
  case llvm::Type::TypeID::FP128TyID : {
    ele_type = bitvector_typet(ID_floatbv, 128);
    break;
  }
  // 128-bit floating point type (two 64-bits, PowerPC)
  case llvm::Type::TypeID::PPC_FP128TyID : {
    ele_type = bitvector_typet(ID_floatbv, 128);
    break;
  }
  case llvm::Type::TypeID::IntegerTyID : {
    if (dyn_cast<ArrayType>(type)
      ->getArrayElementType()->getIntegerBitWidth() == 1) {
    ele_type = bool_typet();
    } else {
    ele_type = unsignedbv_typet(
      dyn_cast<ArrayType>(type)->getArrayElementType()->getIntegerBitWidth());
    }
    break;
  }
  case llvm::Type::TypeID::StructTyID : {
    ele_type = create_struct_union_type(
      dyn_cast<ArrayType>(type)->getArrayElementType(),
      dyn_cast<DICompositeType>(dyn_cast<DICompositeType>(md)->getBaseType()));
    break;
  }
  case llvm::Type::TypeID::ArrayTyID : {
    exprt size = from_integer(
      dyn_cast<ArrayType>(
        dyn_cast<ArrayType>(type)->getArrayElementType())->getNumElements(),
      signedbv_typet(21));
    ele_type = array_typet(
      create_array_type(dyn_cast<ArrayType>(type)->getArrayElementType(),
        dyn_cast<DICompositeType>(
          dyn_cast<DICompositeType>(md)->getBaseType())),
      size);
    break;
  }
  case llvm::Type::TypeID::PointerTyID : {
    typet ptr_type = create_pointer_type(
      dyn_cast<ArrayType>(type)->getArrayElementType(),
    dyn_cast<DIDerivedType>(dyn_cast<DICompositeType>(md)->getBaseType()));
    ele_type = pointer_typet(ptr_type, 23);
    break;
  }
  case llvm::Type::TypeID::VectorTyID : {
    errs() << "\nVector type NO ACTION!!!!";
    break;
  }
  case llvm::Type::TypeID::X86_MMXTyID : {
    errs() << "\n X86_MMX type NO ACTION!!!!";
    break;
  }
  case llvm::Type::TypeID::VoidTyID :
  case llvm::Type::TypeID::FunctionTyID :
  case llvm::Type::TypeID::TokenTyID :
  case llvm::Type::TypeID::LabelTyID :
  case llvm::Type::TypeID::MetadataTyID :
    errs() << "\ninvalid type for global variable";;
  }
  return ele_type;
}

/*******************************************************************\

  Function: symbol_creator::create_PointerTy

  Inputs:
   GV - reference to global variable in llvm module.
   name - name of the global variable

  Outputs: Object of symbolt.

  Purpose: Create apropriate goto symbol in symbol table corresponding to
       llvm global variable.

\*******************************************************************/
symbolt symbol_creator::create_PointerTy(Type *type, MDNode *mdn) {
  symbolt global_variable;
  global_variable.clear();
  if (dyn_cast<DIGlobalVariable>(mdn)) {
    global_variable.is_static_lifetime = true;
  }
  typet ele_type = create_pointer_type(
    type,
    dyn_cast<DIDerivedType>(dyn_cast<DIVariable>(mdn)->getType()));
  pointer_typet pt(ele_type, 25);   /// TODO(Rasika) : set proper value.
  global_variable.type = pt;
  global_variable.location = locationt::get_location_global_variable(
  dyn_cast<DIVariable>(mdn));
  const irep_idt tmp_name = dyn_cast<DIVariable>(mdn)->getName().str();
  global_variable.name = tmp_name;
  return global_variable;
}

/*******************************************************************\

  Function: symbol_creator::create_pointer_type

  Inputs:
   GV - reference to global variable in llvm module.
   md - pointer to DIDerivedType.

  Outputs: Object of struct_union_typet.

  Purpose: Create apropriate goto symbol typet corresponding to given
       llvm pointer type.

\*******************************************************************/
typet symbol_creator::create_pointer_type(Type *type,
  const llvm::DIDerivedType *md) {
  typet ele_type;
  switch (dyn_cast<PointerType>(type)->getPointerElementType()->getTypeID()) {
  // 16-bit floating point type
  case llvm::Type::TypeID::HalfTyID : {
    ele_type = bitvector_typet(ID_floatbv, 16);
  }
  // 32-bit floating point type
  case llvm::Type::TypeID::FloatTyID : {
    ele_type = bitvector_typet(ID_floatbv, 32);
    break;
  }
  // 64-bit floating point type
  case llvm::Type::TypeID::DoubleTyID : {
    ele_type = bitvector_typet(ID_floatbv, 64);
    break;
  }
  // 80-bit floating point type (X87)
  case llvm::Type::TypeID::X86_FP80TyID : {
    ele_type = bitvector_typet(ID_floatbv, 80);
    break;
  }
  // 128-bit floating point type (112-bit mantissa)
  case llvm::Type::TypeID::FP128TyID : {
    ele_type = bitvector_typet(ID_floatbv, 128);
    break;
  }
  // 128-bit floating point type (two 64-bits, PowerPC)
  case llvm::Type::TypeID::PPC_FP128TyID : {
    ele_type = bitvector_typet(ID_floatbv, 128);
    break;
  }
  case llvm::Type::TypeID::IntegerTyID : {
    if (dyn_cast<PointerType>(type)->
      getPointerElementType()->getIntegerBitWidth() == 1) {
    ele_type = bool_typet();
    } else {
    ele_type = unsignedbv_typet(
      dyn_cast<PointerType>(type)
      ->getPointerElementType()->getIntegerBitWidth());
    }
    break;
  }
  case llvm::Type::TypeID::StructTyID : {
    ele_type = create_struct_union_type(
      (dyn_cast<PointerType>(type)->getPointerElementType()),
      dyn_cast<DICompositeType>(dyn_cast<DIDerivedType>(md)->getBaseType()));
    break;
  }
  case llvm::Type::TypeID::ArrayTyID : {
    errs() << "array in pointer";
    exprt size = from_integer(
      dyn_cast<ArrayType>(
        dyn_cast<PointerType>(type)->getPointerElementType())
      ->getNumElements(),
      signedbv_typet(32));
    ele_type = array_typet(
      create_array_type(
        dyn_cast<PointerType>(type)->getPointerElementType(),
        dyn_cast<DICompositeType>(
          dyn_cast<DICompositeType>(md)->getBaseType())),
      size);
    break;
  }
  case llvm::Type::TypeID::PointerTyID : {
    typet ptr_type = create_pointer_type(
      dyn_cast<PointerType>(type)->getPointerElementType(),
      dyn_cast<DIDerivedType>((md)->getBaseType()));
    ele_type = pointer_typet(ptr_type, 15);
    break;
  }
  case llvm::Type::TypeID::VectorTyID : {
    errs() << "\nVector type NO ACTION!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!";
    break;
  }
  case llvm::Type::TypeID::X86_MMXTyID : {
    break;
  }
  case llvm::Type::TypeID::VoidTyID :
  case llvm::Type::TypeID::FunctionTyID :
  case llvm::Type::TypeID::TokenTyID :
  case llvm::Type::TypeID::LabelTyID :
  case llvm::Type::TypeID::MetadataTyID :
    errs() << "\ninvalid type for global variable";
  }
  return ele_type;
}

/*******************************************************************\

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
  global_variable.name = tmp_name;
  return global_variable;
}

/*******************************************************************\

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
  global_variable.name = tmp_name;
  const irep_idt tmp_bname = "tid";
  global_variable.base_name = tmp_bname;
  global_variable.mode = ID_C;
  return global_variable;
}

/*******************************************************************\

  Function: symbol_creator::create_FunctionTy

  Inputs:
   GV - reference to global variable in llvm module.
   name - name of the global variable

  Outputs: Object of symbolt.

  Purpose: Create apropriate goto symbol in symbol table corresponding to
       llvm global variable.

\*******************************************************************/
symbolt symbol_creator::create_FunctionTy(Type *type, MDNode *mdn) {
  symbolt global_variable;
  global_variable.clear();
  if (dyn_cast<DIGlobalVariable>(mdn)) {
    global_variable.is_static_lifetime = true;
  }
  global_variable.location = locationt::get_location_global_variable(
  dyn_cast<DIVariable>(mdn));
  const irep_idt tmp_name = dyn_cast<DIVariable>(mdn)->getName().str();
  global_variable.name = tmp_name;
  return global_variable;
}

/*******************************************************************\

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
  global_variable.name = tmp_name;
  return global_variable;
}

/*******************************************************************\

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
  global_variable.name = tmp_name;
  return global_variable;
}

/*******************************************************************\

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
  global_variable.name = tmp_name;
  return global_variable;
}
