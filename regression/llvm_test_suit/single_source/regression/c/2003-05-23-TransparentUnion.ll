; ModuleID = '2003-05-23-TransparentUnion.c'
source_filename = "2003-05-23-TransparentUnion.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%union.UNION = type { float* }

; Function Attrs: noinline nounwind optnone uwtable
define i32 @try(float* %U.coerce) #0 !dbg !7 {
entry:
  %U = alloca %union.UNION, align 8
  %coerce.dive = getelementptr inbounds %union.UNION, %union.UNION* %U, i32 0, i32 0
  store float* %U.coerce, float** %coerce.dive, align 8
  call void @llvm.dbg.declare(metadata %union.UNION* %U, metadata !19, metadata !20), !dbg !21
  ret i32 1, !dbg !22
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @test() #0 !dbg !23 {
entry:
  %I = alloca i32, align 4
  %F = alloca float, align 4
  %agg.tmp = alloca %union.UNION, align 8
  %agg.tmp1 = alloca %union.UNION, align 8
  call void @llvm.dbg.declare(metadata i32* %I, metadata !26, metadata !20), !dbg !27
  call void @llvm.dbg.declare(metadata float* %F, metadata !28, metadata !20), !dbg !29
  %__iptr = bitcast %union.UNION* %agg.tmp to i32**, !dbg !30
  store i32* %I, i32** %__iptr, align 8, !dbg !30
  %coerce.dive = getelementptr inbounds %union.UNION, %union.UNION* %agg.tmp, i32 0, i32 0, !dbg !31
  %0 = load float*, float** %coerce.dive, align 8, !dbg !31
  %call = call i32 @try(float* %0), !dbg !31
  %__fptr = bitcast %union.UNION* %agg.tmp1 to float**, !dbg !32
  store float* %F, float** %__fptr, align 8, !dbg !32
  %coerce.dive2 = getelementptr inbounds %union.UNION, %union.UNION* %agg.tmp1, i32 0, i32 0, !dbg !33
  %1 = load float*, float** %coerce.dive2, align 8, !dbg !33
  %call3 = call i32 @try(float* %1), !dbg !33
  %or = or i32 %call, %call3, !dbg !34
  ret i32 %or, !dbg !35
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !36 {
entry:
  %retval = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  %call = call i32 @test(), !dbg !37
  %cmp = icmp eq i32 %call, 1, !dbg !38
  %conv = zext i1 %cmp to i32, !dbg !38
  %call1 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !39
  ret i32 0, !dbg !40
}

declare i32 @assert(...) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "2003-05-23-TransparentUnion.c", directory: "/home/ubuntu/llvm2goto/regression/llvm_test_suit/single_source/regression/c")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final)"}
!7 = distinct !DISubprogram(name: "try", scope: !1, file: !1, line: 8, type: !8, isLocal: false, isDefinition: true, scopeLine: 8, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10, !11}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DIDerivedType(tag: DW_TAG_typedef, name: "UNION", file: !1, line: 6, baseType: !12)
!12 = distinct !DICompositeType(tag: DW_TAG_union_type, file: !1, line: 3, size: 64, elements: !13)
!13 = !{!14, !17}
!14 = !DIDerivedType(tag: DW_TAG_member, name: "__fptr", scope: !12, file: !1, line: 4, baseType: !15, size: 64)
!15 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !16, size: 64)
!16 = !DIBasicType(name: "float", size: 32, encoding: DW_ATE_float)
!17 = !DIDerivedType(tag: DW_TAG_member, name: "__iptr", scope: !12, file: !1, line: 5, baseType: !18, size: 64)
!18 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !10, size: 64)
!19 = !DILocalVariable(name: "U", arg: 1, scope: !7, file: !1, line: 8, type: !11)
!20 = !DIExpression()
!21 = !DILocation(line: 8, column: 15, scope: !7)
!22 = !DILocation(line: 9, column: 3, scope: !7)
!23 = distinct !DISubprogram(name: "test", scope: !1, file: !1, line: 11, type: !24, isLocal: false, isDefinition: true, scopeLine: 11, isOptimized: false, unit: !0, variables: !2)
!24 = !DISubroutineType(types: !25)
!25 = !{!10}
!26 = !DILocalVariable(name: "I", scope: !23, file: !1, line: 12, type: !10)
!27 = !DILocation(line: 12, column: 7, scope: !23)
!28 = !DILocalVariable(name: "F", scope: !23, file: !1, line: 13, type: !16)
!29 = !DILocation(line: 13, column: 9, scope: !23)
!30 = !DILocation(line: 14, column: 14, scope: !23)
!31 = !DILocation(line: 14, column: 10, scope: !23)
!32 = !DILocation(line: 14, column: 24, scope: !23)
!33 = !DILocation(line: 14, column: 20, scope: !23)
!34 = !DILocation(line: 14, column: 18, scope: !23)
!35 = !DILocation(line: 14, column: 3, scope: !23)
!36 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 17, type: !24, isLocal: false, isDefinition: true, scopeLine: 17, isOptimized: false, unit: !0, variables: !2)
!37 = !DILocation(line: 19, column: 10, scope: !36)
!38 = !DILocation(line: 19, column: 17, scope: !36)
!39 = !DILocation(line: 19, column: 3, scope: !36)
!40 = !DILocation(line: 20, column: 3, scope: !36)
