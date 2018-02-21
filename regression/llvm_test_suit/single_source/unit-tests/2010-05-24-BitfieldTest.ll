; ModuleID = '2010-05-24-BitfieldTest.c'
source_filename = "2010-05-24-BitfieldTest.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%union.ia32_mcg_cap_t = type { i64 }
%struct.anon = type { i16, [6 x i8] }

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main(i32 %argc, i8** %argv) #0 !dbg !7 {
entry:
  %retval = alloca i32, align 4
  %argc.addr = alloca i32, align 4
  %argv.addr = alloca i8**, align 8
  %ctl_p = alloca i64, align 8
  %ia32_mcg_cap = alloca %union.ia32_mcg_cap_t, align 8
  store i32 0, i32* %retval, align 4
  store i32 %argc, i32* %argc.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %argc.addr, metadata !14, metadata !15), !dbg !16
  store i8** %argv, i8*** %argv.addr, align 8
  call void @llvm.dbg.declare(metadata i8*** %argv.addr, metadata !17, metadata !15), !dbg !18
  call void @llvm.dbg.declare(metadata i64* %ctl_p, metadata !19, metadata !15), !dbg !21
  call void @llvm.dbg.declare(metadata %union.ia32_mcg_cap_t* %ia32_mcg_cap, metadata !22, metadata !15), !dbg !32
  %u64 = bitcast %union.ia32_mcg_cap_t* %ia32_mcg_cap to i64*, !dbg !33
  store i64 2054, i64* %u64, align 8, !dbg !34
  %bits = bitcast %union.ia32_mcg_cap_t* %ia32_mcg_cap to %struct.anon*, !dbg !35
  %0 = bitcast %struct.anon* %bits to i16*, !dbg !36
  %bf.load = load i16, i16* %0, align 8, !dbg !36
  %bf.lshr = lshr i16 %bf.load, 8, !dbg !36
  %bf.clear = and i16 %bf.lshr, 1, !dbg !36
  %bf.cast = zext i16 %bf.clear to i64, !dbg !36
  store i64 %bf.cast, i64* %ctl_p, align 8, !dbg !37
  %1 = load i64, i64* %ctl_p, align 8, !dbg !38
  %cmp = icmp eq i64 %1, 0, !dbg !39
  %conv = zext i1 %cmp to i32, !dbg !39
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !40
  ret i32 0, !dbg !41
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i32 @assert(...) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "2010-05-24-BitfieldTest.c", directory: "/home/ubuntu/llvm2goto/regression/llvm_test_suit/single_source/unit-tests")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final)"}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 12, type: !8, isLocal: false, isDefinition: true, scopeLine: 12, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10, !10, !11}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !12, size: 64)
!12 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !13, size: 64)
!13 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!14 = !DILocalVariable(name: "argc", arg: 1, scope: !7, file: !1, line: 12, type: !10)
!15 = !DIExpression()
!16 = !DILocation(line: 12, column: 14, scope: !7)
!17 = !DILocalVariable(name: "argv", arg: 2, scope: !7, file: !1, line: 12, type: !11)
!18 = !DILocation(line: 12, column: 26, scope: !7)
!19 = !DILocalVariable(name: "ctl_p", scope: !7, file: !1, line: 13, type: !20)
!20 = !DIBasicType(name: "long long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!21 = !DILocation(line: 13, column: 21, scope: !7)
!22 = !DILocalVariable(name: "ia32_mcg_cap", scope: !7, file: !1, line: 14, type: !23)
!23 = !DIDerivedType(tag: DW_TAG_typedef, name: "ia32_mcg_cap_t", file: !1, line: 10, baseType: !24)
!24 = distinct !DICompositeType(tag: DW_TAG_union_type, file: !1, line: 4, size: 64, elements: !25)
!25 = !{!26, !31}
!26 = !DIDerivedType(tag: DW_TAG_member, name: "bits", scope: !24, file: !1, line: 8, baseType: !27, size: 64)
!27 = distinct !DICompositeType(tag: DW_TAG_structure_type, scope: !24, file: !1, line: 5, size: 64, elements: !28)
!28 = !{!29, !30}
!29 = !DIDerivedType(tag: DW_TAG_member, name: "count", scope: !27, file: !1, line: 6, baseType: !20, size: 8, flags: DIFlagBitField, extraData: i64 0)
!30 = !DIDerivedType(tag: DW_TAG_member, name: "mcg_ctl_p", scope: !27, file: !1, line: 7, baseType: !20, size: 1, offset: 8, flags: DIFlagBitField, extraData: i64 0)
!31 = !DIDerivedType(tag: DW_TAG_member, name: "u64", scope: !24, file: !1, line: 9, baseType: !20, size: 64)
!32 = !DILocation(line: 14, column: 19, scope: !7)
!33 = !DILocation(line: 16, column: 15, scope: !7)
!34 = !DILocation(line: 16, column: 19, scope: !7)
!35 = !DILocation(line: 18, column: 23, scope: !7)
!36 = !DILocation(line: 18, column: 28, scope: !7)
!37 = !DILocation(line: 18, column: 8, scope: !7)
!38 = !DILocation(line: 19, column: 9, scope: !7)
!39 = !DILocation(line: 19, column: 15, scope: !7)
!40 = !DILocation(line: 19, column: 2, scope: !7)
!41 = !DILocation(line: 21, column: 2, scope: !7)
