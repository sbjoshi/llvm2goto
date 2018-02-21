; ModuleID = '2004-06-20-StaticBitfieldInit.c'
source_filename = "2004-06-20-StaticBitfieldInit.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@GV = global { i8, i8, [2 x i8] } { i8 -95, i8 8, [2 x i8] undef }, align 4, !dbg !0

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !16 {
entry:
  %retval = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  %bf.load = load i16, i16* bitcast ({ i8, i8, [2 x i8] }* @GV to i16*), align 4, !dbg !20
  %bf.clear = and i16 %bf.load, 31, !dbg !20
  %bf.cast = zext i16 %bf.clear to i32, !dbg !20
  %cmp = icmp eq i32 %bf.cast, 1, !dbg !21
  %conv = zext i1 %cmp to i32, !dbg !21
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !22
  %bf.load1 = load i16, i16* bitcast ({ i8, i8, [2 x i8] }* @GV to i16*), align 4, !dbg !23
  %bf.lshr = lshr i16 %bf.load1, 5, !dbg !23
  %bf.clear2 = and i16 %bf.lshr, 63, !dbg !23
  %bf.cast3 = zext i16 %bf.clear2 to i32, !dbg !23
  %cmp4 = icmp eq i32 %bf.cast3, 5, !dbg !24
  %conv5 = zext i1 %cmp4 to i32, !dbg !24
  %call6 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv5), !dbg !25
  %bf.load7 = load i16, i16* bitcast ({ i8, i8, [2 x i8] }* @GV to i16*), align 4, !dbg !26
  %bf.lshr8 = lshr i16 %bf.load7, 11, !dbg !26
  %bf.cast9 = zext i16 %bf.lshr8 to i32, !dbg !26
  %cmp10 = icmp eq i32 %bf.cast9, 1, !dbg !27
  %conv11 = zext i1 %cmp10 to i32, !dbg !27
  %call12 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv11), !dbg !28
  ret i32 0, !dbg !29
}

declare i32 @assert(...) #1

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!12, !13, !14}
!llvm.ident = !{!15}

!0 = !DIGlobalVariableExpression(var: !1)
!1 = distinct !DIGlobalVariable(name: "GV", scope: !2, file: !3, line: 9, type: !6, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 5.0.1 (tags/RELEASE_501/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !5)
!3 = !DIFile(filename: "2004-06-20-StaticBitfieldInit.c", directory: "/home/ubuntu/llvm2goto/regression/llvm_test_suit/single_source/unit-tests")
!4 = !{}
!5 = !{!0}
!6 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "T", file: !3, line: 3, size: 32, elements: !7)
!7 = !{!8, !10, !11}
!8 = !DIDerivedType(tag: DW_TAG_member, name: "X", scope: !6, file: !3, line: 4, baseType: !9, size: 5, flags: DIFlagBitField, extraData: i64 0)
!9 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!10 = !DIDerivedType(tag: DW_TAG_member, name: "Y", scope: !6, file: !3, line: 5, baseType: !9, size: 6, offset: 5, flags: DIFlagBitField, extraData: i64 0)
!11 = !DIDerivedType(tag: DW_TAG_member, name: "Z", scope: !6, file: !3, line: 6, baseType: !9, size: 5, offset: 11, flags: DIFlagBitField, extraData: i64 0)
!12 = !{i32 2, !"Dwarf Version", i32 4}
!13 = !{i32 2, !"Debug Info Version", i32 3}
!14 = !{i32 1, !"wchar_size", i32 4}
!15 = !{!"clang version 5.0.1 (tags/RELEASE_501/final)"}
!16 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 11, type: !17, isLocal: false, isDefinition: true, scopeLine: 11, isOptimized: false, unit: !2, variables: !4)
!17 = !DISubroutineType(types: !18)
!18 = !{!19}
!19 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!20 = !DILocation(line: 13, column: 12, scope: !16)
!21 = !DILocation(line: 13, column: 14, scope: !16)
!22 = !DILocation(line: 13, column: 2, scope: !16)
!23 = !DILocation(line: 14, column: 12, scope: !16)
!24 = !DILocation(line: 14, column: 14, scope: !16)
!25 = !DILocation(line: 14, column: 2, scope: !16)
!26 = !DILocation(line: 15, column: 12, scope: !16)
!27 = !DILocation(line: 15, column: 14, scope: !16)
!28 = !DILocation(line: 15, column: 2, scope: !16)
!29 = !DILocation(line: 16, column: 3, scope: !16)
