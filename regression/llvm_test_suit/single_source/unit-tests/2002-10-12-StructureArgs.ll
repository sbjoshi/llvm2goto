; ModuleID = '2002-10-12-StructureArgs.c'
source_filename = "2002-10-12-StructureArgs.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.vec2 = type { double, double }

; Function Attrs: noinline nounwind optnone uwtable
define void @print(double %S.coerce0, double %S.coerce1, double %T.coerce0, double %T.coerce1) #0 !dbg !9 {
entry:
  %S = alloca %struct.vec2, align 8
  %T = alloca %struct.vec2, align 8
  %0 = bitcast %struct.vec2* %S to { double, double }*
  %1 = getelementptr inbounds { double, double }, { double, double }* %0, i32 0, i32 0
  store double %S.coerce0, double* %1, align 8
  %2 = getelementptr inbounds { double, double }, { double, double }* %0, i32 0, i32 1
  store double %S.coerce1, double* %2, align 8
  %3 = bitcast %struct.vec2* %T to { double, double }*
  %4 = getelementptr inbounds { double, double }, { double, double }* %3, i32 0, i32 0
  store double %T.coerce0, double* %4, align 8
  %5 = getelementptr inbounds { double, double }, { double, double }* %3, i32 0, i32 1
  store double %T.coerce1, double* %5, align 8
  call void @llvm.dbg.declare(metadata %struct.vec2* %S, metadata !17, metadata !18), !dbg !19
  call void @llvm.dbg.declare(metadata %struct.vec2* %T, metadata !20, metadata !18), !dbg !21
  %X = getelementptr inbounds %struct.vec2, %struct.vec2* %S, i32 0, i32 0, !dbg !22
  %6 = load double, double* %X, align 8, !dbg !22
  %conv = fptrunc double %6 to float, !dbg !23
  %conv1 = fpext float %conv to double, !dbg !23
  %cmp = fcmp oeq double %conv1, 5.000000e-01, !dbg !24
  %conv2 = zext i1 %cmp to i32, !dbg !24
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv2), !dbg !25
  %Y = getelementptr inbounds %struct.vec2, %struct.vec2* %S, i32 0, i32 1, !dbg !26
  %7 = load double, double* %Y, align 8, !dbg !26
  %conv3 = fptrunc double %7 to float, !dbg !27
  %conv4 = fpext float %conv3 to double, !dbg !27
  %cmp5 = fcmp oeq double %conv4, 1.200000e+00, !dbg !28
  %conv6 = zext i1 %cmp5 to i32, !dbg !28
  %call7 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv6), !dbg !29
  %X8 = getelementptr inbounds %struct.vec2, %struct.vec2* %T, i32 0, i32 0, !dbg !30
  %8 = load double, double* %X8, align 8, !dbg !30
  %conv9 = fptrunc double %8 to float, !dbg !31
  %conv10 = fpext float %conv9 to double, !dbg !31
  %cmp11 = fcmp oeq double %conv10, -1.230100e+02, !dbg !32
  %conv12 = zext i1 %cmp11 to i32, !dbg !32
  %call13 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv12), !dbg !33
  %Y14 = getelementptr inbounds %struct.vec2, %struct.vec2* %T, i32 0, i32 1, !dbg !34
  %9 = load double, double* %Y14, align 8, !dbg !34
  %conv15 = fptrunc double %9 to float, !dbg !35
  %conv16 = fpext float %conv15 to double, !dbg !35
  %cmp17 = fcmp oeq double %conv16, 3.333330e-01, !dbg !36
  %conv18 = zext i1 %cmp17 to i32, !dbg !36
  %call19 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv18), !dbg !37
  ret void, !dbg !38
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i32 @assert(...) #2

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !39 {
entry:
  %retval = alloca i32, align 4
  %U = alloca %struct.vec2, align 8
  %V = alloca %struct.vec2, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.vec2* %U, metadata !43, metadata !18), !dbg !44
  call void @llvm.dbg.declare(metadata %struct.vec2* %V, metadata !45, metadata !18), !dbg !46
  %X = getelementptr inbounds %struct.vec2, %struct.vec2* %U, i32 0, i32 0, !dbg !47
  store double 5.000000e-01, double* %X, align 8, !dbg !48
  %Y = getelementptr inbounds %struct.vec2, %struct.vec2* %U, i32 0, i32 1, !dbg !49
  store double 1.200000e+00, double* %Y, align 8, !dbg !50
  %X1 = getelementptr inbounds %struct.vec2, %struct.vec2* %V, i32 0, i32 0, !dbg !51
  store double -1.230100e+02, double* %X1, align 8, !dbg !52
  %Y2 = getelementptr inbounds %struct.vec2, %struct.vec2* %V, i32 0, i32 1, !dbg !53
  store double 0x3FD5555555555555, double* %Y2, align 8, !dbg !54
  %0 = bitcast %struct.vec2* %U to { double, double }*, !dbg !55
  %1 = getelementptr inbounds { double, double }, { double, double }* %0, i32 0, i32 0, !dbg !55
  %2 = load double, double* %1, align 8, !dbg !55
  %3 = getelementptr inbounds { double, double }, { double, double }* %0, i32 0, i32 1, !dbg !55
  %4 = load double, double* %3, align 8, !dbg !55
  %5 = bitcast %struct.vec2* %V to { double, double }*, !dbg !55
  %6 = getelementptr inbounds { double, double }, { double, double }* %5, i32 0, i32 0, !dbg !55
  %7 = load double, double* %6, align 8, !dbg !55
  %8 = getelementptr inbounds { double, double }, { double, double }* %5, i32 0, i32 1, !dbg !55
  %9 = load double, double* %8, align 8, !dbg !55
  call void @print(double %2, double %4, double %7, double %9), !dbg !55
  ret i32 0, !dbg !56
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!5, !6, !7}
!llvm.ident = !{!8}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3)
!1 = !DIFile(filename: "2002-10-12-StructureArgs.c", directory: "/home/ubuntu/llvm2goto/regression/llvm_test_suit/single_source/unit-tests")
!2 = !{}
!3 = !{!4}
!4 = !DIBasicType(name: "float", size: 32, encoding: DW_ATE_float)
!5 = !{i32 2, !"Dwarf Version", i32 4}
!6 = !{i32 2, !"Debug Info Version", i32 3}
!7 = !{i32 1, !"wchar_size", i32 4}
!8 = !{!"clang version 5.0.1 (tags/RELEASE_501/final)"}
!9 = distinct !DISubprogram(name: "print", scope: !1, file: !1, line: 5, type: !10, isLocal: false, isDefinition: true, scopeLine: 5, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!10 = !DISubroutineType(types: !11)
!11 = !{null, !12, !12}
!12 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "vec2", file: !1, line: 3, size: 128, elements: !13)
!13 = !{!14, !16}
!14 = !DIDerivedType(tag: DW_TAG_member, name: "X", scope: !12, file: !1, line: 3, baseType: !15, size: 64)
!15 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!16 = !DIDerivedType(tag: DW_TAG_member, name: "Y", scope: !12, file: !1, line: 3, baseType: !15, size: 64, offset: 64)
!17 = !DILocalVariable(name: "S", arg: 1, scope: !9, file: !1, line: 5, type: !12)
!18 = !DIExpression()
!19 = !DILocation(line: 5, column: 24, scope: !9)
!20 = !DILocalVariable(name: "T", arg: 2, scope: !9, file: !1, line: 5, type: !12)
!21 = !DILocation(line: 5, column: 39, scope: !9)
!22 = !DILocation(line: 7, column: 18, scope: !9)
!23 = !DILocation(line: 7, column: 9, scope: !9)
!24 = !DILocation(line: 7, column: 20, scope: !9)
!25 = !DILocation(line: 7, column: 2, scope: !9)
!26 = !DILocation(line: 8, column: 18, scope: !9)
!27 = !DILocation(line: 8, column: 9, scope: !9)
!28 = !DILocation(line: 8, column: 20, scope: !9)
!29 = !DILocation(line: 8, column: 2, scope: !9)
!30 = !DILocation(line: 9, column: 18, scope: !9)
!31 = !DILocation(line: 9, column: 9, scope: !9)
!32 = !DILocation(line: 9, column: 20, scope: !9)
!33 = !DILocation(line: 9, column: 2, scope: !9)
!34 = !DILocation(line: 10, column: 18, scope: !9)
!35 = !DILocation(line: 10, column: 9, scope: !9)
!36 = !DILocation(line: 10, column: 20, scope: !9)
!37 = !DILocation(line: 10, column: 2, scope: !9)
!38 = !DILocation(line: 11, column: 1, scope: !9)
!39 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 13, type: !40, isLocal: false, isDefinition: true, scopeLine: 13, isOptimized: false, unit: !0, variables: !2)
!40 = !DISubroutineType(types: !41)
!41 = !{!42}
!42 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!43 = !DILocalVariable(name: "U", scope: !39, file: !1, line: 14, type: !12)
!44 = !DILocation(line: 14, column: 14, scope: !39)
!45 = !DILocalVariable(name: "V", scope: !39, file: !1, line: 14, type: !12)
!46 = !DILocation(line: 14, column: 17, scope: !39)
!47 = !DILocation(line: 15, column: 4, scope: !39)
!48 = !DILocation(line: 15, column: 6, scope: !39)
!49 = !DILocation(line: 15, column: 14, scope: !39)
!50 = !DILocation(line: 15, column: 16, scope: !39)
!51 = !DILocation(line: 16, column: 4, scope: !39)
!52 = !DILocation(line: 16, column: 6, scope: !39)
!53 = !DILocation(line: 16, column: 19, scope: !39)
!54 = !DILocation(line: 16, column: 21, scope: !39)
!55 = !DILocation(line: 17, column: 2, scope: !39)
!56 = !DILocation(line: 18, column: 2, scope: !39)
