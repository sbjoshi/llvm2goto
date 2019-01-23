; ModuleID = 'Pointer_byte_extract6/main.c'
source_filename = "Pointer_byte_extract6/main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.some = type { i32 }

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !10 {
entry:
  %signed_int = alloca i32, align 4
  %a_float = alloca float, align 4
  %a_double = alloca double, align 8
  %long_long_int = alloca i64, align 8
  call void @llvm.dbg.declare(metadata i32* %signed_int, metadata !25, metadata !DIExpression()), !dbg !26
  store i32 1, i32* %signed_int, align 4, !dbg !26
  call void @llvm.dbg.declare(metadata float* %a_float, metadata !27, metadata !DIExpression()), !dbg !28
  store float 1.000000e+00, float* %a_float, align 4, !dbg !28
  call void @llvm.dbg.declare(metadata double* %a_double, metadata !29, metadata !DIExpression()), !dbg !31
  store double 1.000000e+00, double* %a_double, align 8, !dbg !31
  call void @llvm.dbg.declare(metadata i64* %long_long_int, metadata !32, metadata !DIExpression()), !dbg !33
  store i64 1, i64* %long_long_int, align 8, !dbg !33
  %0 = load i64, i64* %long_long_int, align 8, !dbg !34
  %cmp = icmp eq i64 %0, 1, !dbg !35
  %conv = zext i1 %cmp to i32, !dbg !35
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !36
  %1 = load i32, i32* %signed_int, align 4, !dbg !37
  %cmp1 = icmp eq i32 %1, 1, !dbg !38
  %conv2 = zext i1 %cmp1 to i32, !dbg !38
  %call3 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv2), !dbg !39
  %2 = bitcast i32* %signed_int to %struct.some*, !dbg !40
  %f = getelementptr inbounds %struct.some, %struct.some* %2, i32 0, i32 0, !dbg !40
  %3 = load i32, i32* %f, align 4, !dbg !40
  %cmp4 = icmp eq i32 %3, 1, !dbg !41
  %conv5 = zext i1 %cmp4 to i32, !dbg !41
  %call6 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv5), !dbg !42
  %4 = bitcast float* %a_float to i32*, !dbg !43
  %5 = load i32, i32* %4, align 4, !dbg !43
  %cmp7 = icmp eq i32 %5, 1065353216, !dbg !44
  %conv8 = zext i1 %cmp7 to i32, !dbg !44
  %call9 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv8), !dbg !45
  %6 = bitcast double* %a_double to i64*, !dbg !46
  %7 = load i64, i64* %6, align 8, !dbg !46
  %cmp10 = icmp eq i64 %7, 4607182418800017408, !dbg !47
  %conv11 = zext i1 %cmp10 to i32, !dbg !47
  %call12 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv11), !dbg !48
  store i32 1065353216, i32* %signed_int, align 4, !dbg !49
  %8 = bitcast i32* %signed_int to float*, !dbg !50
  %9 = load float, float* %8, align 4, !dbg !50
  %cmp13 = fcmp oeq float %9, 1.000000e+00, !dbg !51
  %conv14 = zext i1 %cmp13 to i32, !dbg !51
  %call15 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv14), !dbg !52
  ret i32 0, !dbg !53
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare dso_local i32 @assert(...) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!21, !22, !23}
!llvm.ident = !{!24}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 7.0.1 (https://github.com/llvm-mirror/clang.git 4519e2637fcc4bf6e3049a0a80e6a5e7b97667cb) (https://github.com/llvm-mirror/llvm.git cd98f42d0747826062fc3d2d2fad383aedf58dd6)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3)
!1 = !DIFile(filename: "Pointer_byte_extract6/main.c", directory: "/home/akash/Documents/CBMC/cbmc/src/llvm2goto/regression")
!2 = !{}
!3 = !{!4, !6, !8, !16, !17, !19}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !5, size: 64)
!5 = !DIBasicType(name: "long long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!6 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !7, size: 64)
!7 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!8 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !9, size: 64)
!9 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "some", scope: !10, file: !1, line: 9, size: 32, elements: !14)
!10 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 2, type: !11, isLocal: false, isDefinition: true, scopeLine: 3, isOptimized: false, unit: !0, retainedNodes: !2)
!11 = !DISubroutineType(types: !12)
!12 = !{!13}
!13 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!14 = !{!15}
!15 = !DIDerivedType(tag: DW_TAG_member, name: "f", scope: !9, file: !1, line: 11, baseType: !13, size: 32)
!16 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !13, size: 64)
!17 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !18, size: 64)
!18 = !DIBasicType(name: "long long int", size: 64, encoding: DW_ATE_signed)
!19 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !20, size: 64)
!20 = !DIBasicType(name: "float", size: 32, encoding: DW_ATE_float)
!21 = !{i32 2, !"Dwarf Version", i32 4}
!22 = !{i32 2, !"Debug Info Version", i32 3}
!23 = !{i32 1, !"wchar_size", i32 4}
!24 = !{!"clang version 7.0.1 (https://github.com/llvm-mirror/clang.git 4519e2637fcc4bf6e3049a0a80e6a5e7b97667cb) (https://github.com/llvm-mirror/llvm.git cd98f42d0747826062fc3d2d2fad383aedf58dd6)"}
!25 = !DILocalVariable(name: "signed_int", scope: !10, file: !1, line: 4, type: !13)
!26 = !DILocation(line: 4, column: 7, scope: !10)
!27 = !DILocalVariable(name: "a_float", scope: !10, file: !1, line: 5, type: !20)
!28 = !DILocation(line: 5, column: 9, scope: !10)
!29 = !DILocalVariable(name: "a_double", scope: !10, file: !1, line: 6, type: !30)
!30 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!31 = !DILocation(line: 6, column: 10, scope: !10)
!32 = !DILocalVariable(name: "long_long_int", scope: !10, file: !1, line: 7, type: !18)
!33 = !DILocation(line: 7, column: 13, scope: !10)
!34 = !DILocation(line: 14, column: 10, scope: !10)
!35 = !DILocation(line: 14, column: 51, scope: !10)
!36 = !DILocation(line: 14, column: 3, scope: !10)
!37 = !DILocation(line: 15, column: 10, scope: !10)
!38 = !DILocation(line: 15, column: 38, scope: !10)
!39 = !DILocation(line: 15, column: 3, scope: !10)
!40 = !DILocation(line: 16, column: 40, scope: !10)
!41 = !DILocation(line: 16, column: 41, scope: !10)
!42 = !DILocation(line: 16, column: 3, scope: !10)
!43 = !DILocation(line: 17, column: 10, scope: !10)
!44 = !DILocation(line: 17, column: 26, scope: !10)
!45 = !DILocation(line: 17, column: 3, scope: !10)
!46 = !DILocation(line: 18, column: 10, scope: !10)
!47 = !DILocation(line: 18, column: 37, scope: !10)
!48 = !DILocation(line: 18, column: 3, scope: !10)
!49 = !DILocation(line: 21, column: 13, scope: !10)
!50 = !DILocation(line: 22, column: 10, scope: !10)
!51 = !DILocation(line: 22, column: 31, scope: !10)
!52 = !DILocation(line: 22, column: 3, scope: !10)
!53 = !DILocation(line: 23, column: 1, scope: !10)
