; ModuleID = '2003-10-12-GlobalVarInitializers.c'
source_filename = "2003-10-12-GlobalVarInitializers.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%union.anon = type { i32 }
%union.anon.0 = type { i32 }

@GlobalUnion = global %union.anon { i32 1891631104 }, align 4, !dbg !0
@main.LocalUnion = private unnamed_addr constant %union.anon.0 { i32 2143289344 }, align 4

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !16 {
entry:
  %retval = alloca i32, align 4
  %LocalUnion = alloca %union.anon.0, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %union.anon.0* %LocalUnion, metadata !20, metadata !25), !dbg !26
  %0 = bitcast %union.anon.0* %LocalUnion to i8*, !dbg !26
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %0, i8* bitcast (%union.anon.0* @main.LocalUnion to i8*), i64 4, i32 4, i1 false), !dbg !26
  %1 = load float, float* bitcast (%union.anon* @GlobalUnion to float*), align 4, !dbg !27
  %conv = fpext float %1 to double, !dbg !28
  %cmp = fcmp oeq double %conv, 0x4618000000000000, !dbg !29
  %conv1 = zext i1 %cmp to i32, !dbg !29
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv1), !dbg !30
  %__d = bitcast %union.anon.0* %LocalUnion to float*, !dbg !31
  %2 = load float, float* %__d, align 4, !dbg !31
  %cmp2 = fcmp oeq float %2, 0x7FF8000000000000, !dbg !32
  %conv3 = zext i1 %cmp2 to i32, !dbg !32
  %call4 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv3), !dbg !33
  ret i32 0, !dbg !34
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i32, i1) #2

declare i32 @assert(...) #3

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { argmemonly nounwind }
attributes #3 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!12, !13, !14}
!llvm.ident = !{!15}

!0 = !DIGlobalVariableExpression(var: !1)
!1 = distinct !DIGlobalVariable(name: "GlobalUnion", scope: !2, file: !3, line: 5, type: !6, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 5.0.1 (tags/RELEASE_501/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !5)
!3 = !DIFile(filename: "2003-10-12-GlobalVarInitializers.c", directory: "/home/ubuntu/llvm2goto/regression/llvm_test_suit/single_source/regression/c")
!4 = !{}
!5 = !{!0}
!6 = distinct !DICompositeType(tag: DW_TAG_union_type, file: !3, line: 5, size: 32, elements: !7)
!7 = !{!8, !10}
!8 = !DIDerivedType(tag: DW_TAG_member, name: "__l", scope: !6, file: !3, line: 5, baseType: !9, size: 32)
!9 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!10 = !DIDerivedType(tag: DW_TAG_member, name: "__d", scope: !6, file: !3, line: 5, baseType: !11, size: 32)
!11 = !DIBasicType(name: "float", size: 32, encoding: DW_ATE_float)
!12 = !{i32 2, !"Dwarf Version", i32 4}
!13 = !{i32 2, !"Debug Info Version", i32 3}
!14 = !{i32 1, !"wchar_size", i32 4}
!15 = !{!"clang version 5.0.1 (tags/RELEASE_501/final)"}
!16 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 7, type: !17, isLocal: false, isDefinition: true, scopeLine: 7, isOptimized: false, unit: !2, variables: !4)
!17 = !DISubroutineType(types: !18)
!18 = !{!19}
!19 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!20 = !DILocalVariable(name: "LocalUnion", scope: !16, file: !3, line: 8, type: !21)
!21 = distinct !DICompositeType(tag: DW_TAG_union_type, scope: !16, file: !3, line: 8, size: 32, elements: !22)
!22 = !{!23, !24}
!23 = !DIDerivedType(tag: DW_TAG_member, name: "__l", scope: !21, file: !3, line: 8, baseType: !9, size: 32)
!24 = !DIDerivedType(tag: DW_TAG_member, name: "__d", scope: !21, file: !3, line: 8, baseType: !11, size: 32)
!25 = !DIExpression()
!26 = !DILocation(line: 8, column: 38, scope: !16)
!27 = !DILocation(line: 11, column: 22, scope: !16)
!28 = !DILocation(line: 11, column: 10, scope: !16)
!29 = !DILocation(line: 11, column: 26, scope: !16)
!30 = !DILocation(line: 11, column: 3, scope: !16)
!31 = !DILocation(line: 12, column: 21, scope: !16)
!32 = !DILocation(line: 12, column: 25, scope: !16)
!33 = !DILocation(line: 12, column: 3, scope: !16)
!34 = !DILocation(line: 14, column: 3, scope: !16)
