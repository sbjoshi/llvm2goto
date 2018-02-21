; ModuleID = '2002-10-12-StructureArgsSimple.c'
source_filename = "2002-10-12-StructureArgsSimple.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.vec2 = type { double, double }

; Function Attrs: noinline nounwind optnone uwtable
define void @print(double %S.coerce0, double %S.coerce1) #0 !dbg !9 {
entry:
  %S = alloca %struct.vec2, align 8
  %0 = bitcast %struct.vec2* %S to { double, double }*
  %1 = getelementptr inbounds { double, double }, { double, double }* %0, i32 0, i32 0
  store double %S.coerce0, double* %1, align 8
  %2 = getelementptr inbounds { double, double }, { double, double }* %0, i32 0, i32 1
  store double %S.coerce1, double* %2, align 8
  call void @llvm.dbg.declare(metadata %struct.vec2* %S, metadata !17, metadata !18), !dbg !19
  %X = getelementptr inbounds %struct.vec2, %struct.vec2* %S, i32 0, i32 0, !dbg !20
  %3 = load double, double* %X, align 8, !dbg !20
  %conv = fptrunc double %3 to float, !dbg !21
  %conv1 = fpext float %conv to double, !dbg !21
  %cmp = fcmp oeq double %conv1, 5.000000e-01, !dbg !22
  %conv2 = zext i1 %cmp to i32, !dbg !22
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv2), !dbg !23
  %Y = getelementptr inbounds %struct.vec2, %struct.vec2* %S, i32 0, i32 1, !dbg !24
  %4 = load double, double* %Y, align 8, !dbg !24
  %conv3 = fptrunc double %4 to float, !dbg !25
  %conv4 = fpext float %conv3 to double, !dbg !25
  %cmp5 = fcmp oeq double %conv4, 1.200000e+00, !dbg !26
  %conv6 = zext i1 %cmp5 to i32, !dbg !26
  %call7 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv6), !dbg !27
  ret void, !dbg !28
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i32 @assert(...) #2

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !29 {
entry:
  %retval = alloca i32, align 4
  %U = alloca %struct.vec2, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.vec2* %U, metadata !33, metadata !18), !dbg !34
  %X = getelementptr inbounds %struct.vec2, %struct.vec2* %U, i32 0, i32 0, !dbg !35
  store double 5.000000e-01, double* %X, align 8, !dbg !36
  %Y = getelementptr inbounds %struct.vec2, %struct.vec2* %U, i32 0, i32 1, !dbg !37
  store double 1.200000e+00, double* %Y, align 8, !dbg !38
  %0 = bitcast %struct.vec2* %U to { double, double }*, !dbg !39
  %1 = getelementptr inbounds { double, double }, { double, double }* %0, i32 0, i32 0, !dbg !39
  %2 = load double, double* %1, align 8, !dbg !39
  %3 = getelementptr inbounds { double, double }, { double, double }* %0, i32 0, i32 1, !dbg !39
  %4 = load double, double* %3, align 8, !dbg !39
  call void @print(double %2, double %4), !dbg !39
  ret i32 0, !dbg !40
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!5, !6, !7}
!llvm.ident = !{!8}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3)
!1 = !DIFile(filename: "2002-10-12-StructureArgsSimple.c", directory: "/home/ubuntu/llvm2goto/regression/llvm_test_suit/single_source/unit-tests")
!2 = !{}
!3 = !{!4}
!4 = !DIBasicType(name: "float", size: 32, encoding: DW_ATE_float)
!5 = !{i32 2, !"Dwarf Version", i32 4}
!6 = !{i32 2, !"Debug Info Version", i32 3}
!7 = !{i32 1, !"wchar_size", i32 4}
!8 = !{!"clang version 5.0.1 (tags/RELEASE_501/final)"}
!9 = distinct !DISubprogram(name: "print", scope: !1, file: !1, line: 5, type: !10, isLocal: false, isDefinition: true, scopeLine: 5, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!10 = !DISubroutineType(types: !11)
!11 = !{null, !12}
!12 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "vec2", file: !1, line: 3, size: 128, elements: !13)
!13 = !{!14, !16}
!14 = !DIDerivedType(tag: DW_TAG_member, name: "X", scope: !12, file: !1, line: 3, baseType: !15, size: 64)
!15 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!16 = !DIDerivedType(tag: DW_TAG_member, name: "Y", scope: !12, file: !1, line: 3, baseType: !15, size: 64, offset: 64)
!17 = !DILocalVariable(name: "S", arg: 1, scope: !9, file: !1, line: 5, type: !12)
!18 = !DIExpression()
!19 = !DILocation(line: 5, column: 24, scope: !9)
!20 = !DILocation(line: 7, column: 18, scope: !9)
!21 = !DILocation(line: 7, column: 9, scope: !9)
!22 = !DILocation(line: 7, column: 20, scope: !9)
!23 = !DILocation(line: 7, column: 2, scope: !9)
!24 = !DILocation(line: 8, column: 18, scope: !9)
!25 = !DILocation(line: 8, column: 9, scope: !9)
!26 = !DILocation(line: 8, column: 20, scope: !9)
!27 = !DILocation(line: 8, column: 2, scope: !9)
!28 = !DILocation(line: 9, column: 1, scope: !9)
!29 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 11, type: !30, isLocal: false, isDefinition: true, scopeLine: 11, isOptimized: false, unit: !0, variables: !2)
!30 = !DISubroutineType(types: !31)
!31 = !{!32}
!32 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!33 = !DILocalVariable(name: "U", scope: !29, file: !1, line: 12, type: !12)
!34 = !DILocation(line: 12, column: 14, scope: !29)
!35 = !DILocation(line: 13, column: 4, scope: !29)
!36 = !DILocation(line: 13, column: 6, scope: !29)
!37 = !DILocation(line: 13, column: 14, scope: !29)
!38 = !DILocation(line: 13, column: 16, scope: !29)
!39 = !DILocation(line: 14, column: 2, scope: !29)
!40 = !DILocation(line: 15, column: 2, scope: !29)
