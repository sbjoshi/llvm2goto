; ModuleID = '2003-05-21-UnionTest.c'
source_filename = "2003-05-21-UnionTest.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%union.anon = type { double, [8 x i8] }

; Function Attrs: noinline nounwind optnone uwtable
define i32 @__signbit(double %__x) #0 !dbg !7 {
entry:
  %__x.addr = alloca double, align 8
  %__u = alloca %union.anon, align 8
  store double %__x, double* %__x.addr, align 8
  call void @llvm.dbg.declare(metadata double* %__x.addr, metadata !12, metadata !13), !dbg !14
  call void @llvm.dbg.declare(metadata %union.anon* %__u, metadata !15, metadata !13), !dbg !23
  %__d = bitcast %union.anon* %__u to double*, !dbg !24
  %0 = load double, double* %__x.addr, align 8, !dbg !25
  store double %0, double* %__d, align 8, !dbg !24
  %__i = bitcast %union.anon* %__u to [3 x i32]*, !dbg !26
  %arrayidx = getelementptr inbounds [3 x i32], [3 x i32]* %__i, i64 0, i64 1, !dbg !27
  %1 = load i32, i32* %arrayidx, align 4, !dbg !27
  %cmp = icmp slt i32 %1, 0, !dbg !28
  %conv = zext i1 %cmp to i32, !dbg !28
  ret i32 %conv, !dbg !29
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !30 {
entry:
  %retval = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  %call = call i32 @__signbit(double -1.000000e+00), !dbg !33
  %cmp = icmp eq i32 %call, 1, !dbg !34
  %conv = zext i1 %cmp to i32, !dbg !34
  %call1 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !35
  %call2 = call i32 @__signbit(double 2.000000e+00), !dbg !36
  %call3 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %call2), !dbg !37
  ret i32 0, !dbg !38
}

declare i32 @assert(...) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "2003-05-21-UnionTest.c", directory: "/home/ubuntu/llvm2goto/regression/llvm_test_suit/single_source/regression/c")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final)"}
!7 = distinct !DISubprogram(name: "__signbit", scope: !1, file: !1, line: 3, type: !8, isLocal: false, isDefinition: true, scopeLine: 3, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10, !11}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!12 = !DILocalVariable(name: "__x", arg: 1, scope: !7, file: !1, line: 3, type: !11)
!13 = !DIExpression()
!14 = !DILocation(line: 3, column: 23, scope: !7)
!15 = !DILocalVariable(name: "__u", scope: !7, file: !1, line: 4, type: !16)
!16 = distinct !DICompositeType(tag: DW_TAG_union_type, scope: !7, file: !1, line: 4, size: 128, elements: !17)
!17 = !{!18, !19}
!18 = !DIDerivedType(tag: DW_TAG_member, name: "__d", scope: !16, file: !1, line: 4, baseType: !11, size: 64)
!19 = !DIDerivedType(tag: DW_TAG_member, name: "__i", scope: !16, file: !1, line: 4, baseType: !20, size: 96)
!20 = !DICompositeType(tag: DW_TAG_array_type, baseType: !10, size: 96, elements: !21)
!21 = !{!22}
!22 = !DISubrange(count: 3)
!23 = !DILocation(line: 4, column: 37, scope: !7)
!24 = !DILocation(line: 4, column: 43, scope: !7)
!25 = !DILocation(line: 4, column: 50, scope: !7)
!26 = !DILocation(line: 5, column: 14, scope: !7)
!27 = !DILocation(line: 5, column: 10, scope: !7)
!28 = !DILocation(line: 5, column: 21, scope: !7)
!29 = !DILocation(line: 5, column: 3, scope: !7)
!30 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 8, type: !31, isLocal: false, isDefinition: true, scopeLine: 8, isOptimized: false, unit: !0, variables: !2)
!31 = !DISubroutineType(types: !32)
!32 = !{!10}
!33 = !DILocation(line: 10, column: 9, scope: !30)
!34 = !DILocation(line: 10, column: 23, scope: !30)
!35 = !DILocation(line: 10, column: 2, scope: !30)
!36 = !DILocation(line: 11, column: 9, scope: !30)
!37 = !DILocation(line: 11, column: 2, scope: !30)
!38 = !DILocation(line: 12, column: 3, scope: !30)
