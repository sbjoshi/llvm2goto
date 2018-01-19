; ModuleID = 'fun.c'
source_filename = "fun.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.ST = type { i32, double, %struct.RT }
%struct.RT = type { i8, [10 x [20 x i32]], i8 }

; Function Attrs: noinline nounwind optnone uwtable
define i32* @foo(%struct.ST* %s) #0 !dbg !7 {
entry:
  %s.addr = alloca %struct.ST*, align 8
  store %struct.ST* %s, %struct.ST** %s.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.ST** %s.addr, metadata !29, metadata !30), !dbg !31
  %0 = load %struct.ST*, %struct.ST** %s.addr, align 8, !dbg !32
  %arrayidx = getelementptr inbounds %struct.ST, %struct.ST* %0, i64 1, !dbg !32
  %Z = getelementptr inbounds %struct.ST, %struct.ST* %arrayidx, i32 0, i32 2, !dbg !33
  %B = getelementptr inbounds %struct.RT, %struct.RT* %Z, i32 0, i32 1, !dbg !34
  %arrayidx1 = getelementptr inbounds [10 x [20 x i32]], [10 x [20 x i32]]* %B, i64 0, i64 5, !dbg !32
  %arrayidx2 = getelementptr inbounds [20 x i32], [20 x i32]* %arrayidx1, i64 0, i64 13, !dbg !32
  ret i32* %arrayidx2, !dbg !35
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "fun.c", directory: "/home/ubuntu/llvm2goto/regression/c/compositre_types")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final)"}
!7 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 12, type: !8, isLocal: false, isDefinition: true, scopeLine: 12, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10, !12}
!10 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !11, size: 64)
!11 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!12 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !13, size: 64)
!13 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ST", file: !1, line: 6, size: 6592, elements: !14)
!14 = !{!15, !16, !18}
!15 = !DIDerivedType(tag: DW_TAG_member, name: "X", scope: !13, file: !1, line: 7, baseType: !11, size: 32)
!16 = !DIDerivedType(tag: DW_TAG_member, name: "Y", scope: !13, file: !1, line: 8, baseType: !17, size: 64, offset: 64)
!17 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!18 = !DIDerivedType(tag: DW_TAG_member, name: "Z", scope: !13, file: !1, line: 9, baseType: !19, size: 6464, offset: 128)
!19 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "RT", file: !1, line: 1, size: 6464, elements: !20)
!20 = !{!21, !23, !28}
!21 = !DIDerivedType(tag: DW_TAG_member, name: "A", scope: !19, file: !1, line: 2, baseType: !22, size: 8)
!22 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!23 = !DIDerivedType(tag: DW_TAG_member, name: "B", scope: !19, file: !1, line: 3, baseType: !24, size: 6400, offset: 32)
!24 = !DICompositeType(tag: DW_TAG_array_type, baseType: !11, size: 6400, elements: !25)
!25 = !{!26, !27}
!26 = !DISubrange(count: 10)
!27 = !DISubrange(count: 20)
!28 = !DIDerivedType(tag: DW_TAG_member, name: "C", scope: !19, file: !1, line: 4, baseType: !22, size: 8, offset: 6432)
!29 = !DILocalVariable(name: "s", arg: 1, scope: !7, file: !1, line: 12, type: !12)
!30 = !DIExpression()
!31 = !DILocation(line: 12, column: 21, scope: !7)
!32 = !DILocation(line: 13, column: 11, scope: !7)
!33 = !DILocation(line: 13, column: 16, scope: !7)
!34 = !DILocation(line: 13, column: 18, scope: !7)
!35 = !DILocation(line: 13, column: 3, scope: !7)
