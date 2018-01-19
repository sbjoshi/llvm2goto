; ModuleID = 'array_in_struct.c'
source_filename = "array_in_struct.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.s = type { [10 x i32], i32, %struct.p }
%struct.p = type { i8, float, [20 x i32] }

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !7 {
entry:
  %ele = alloca %struct.s, align 4
  call void @llvm.dbg.declare(metadata %struct.s* %ele, metadata !11, metadata !30), !dbg !31
  %pele = getelementptr inbounds %struct.s, %struct.s* %ele, i32 0, i32 2, !dbg !32
  %ar = getelementptr inbounds %struct.p, %struct.p* %pele, i32 0, i32 2, !dbg !33
  %arrayidx = getelementptr inbounds [20 x i32], [20 x i32]* %ar, i64 0, i64 4, !dbg !34
  store i32 10, i32* %arrayidx, align 4, !dbg !35
  ret i32 0, !dbg !36
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "array_in_struct.c", directory: "/home/ubuntu/llvm2goto/regression/c/compositre_types")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final)"}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 11, type: !8, isLocal: false, isDefinition: true, scopeLine: 11, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "ele", scope: !7, file: !1, line: 12, type: !12)
!12 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s", file: !1, line: 6, size: 1056, elements: !13)
!13 = !{!14, !18, !19}
!14 = !DIDerivedType(tag: DW_TAG_member, name: "arr", scope: !12, file: !1, line: 7, baseType: !15, size: 320)
!15 = !DICompositeType(tag: DW_TAG_array_type, baseType: !10, size: 320, elements: !16)
!16 = !{!17}
!17 = !DISubrange(count: 10)
!18 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !12, file: !1, line: 8, baseType: !10, size: 32, offset: 320)
!19 = !DIDerivedType(tag: DW_TAG_member, name: "pele", scope: !12, file: !1, line: 9, baseType: !20, size: 704, offset: 352)
!20 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "p", file: !1, line: 1, size: 704, elements: !21)
!21 = !{!22, !24, !26}
!22 = !DIDerivedType(tag: DW_TAG_member, name: "c", scope: !20, file: !1, line: 2, baseType: !23, size: 8)
!23 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!24 = !DIDerivedType(tag: DW_TAG_member, name: "f", scope: !20, file: !1, line: 3, baseType: !25, size: 32, offset: 32)
!25 = !DIBasicType(name: "float", size: 32, encoding: DW_ATE_float)
!26 = !DIDerivedType(tag: DW_TAG_member, name: "ar", scope: !20, file: !1, line: 4, baseType: !27, size: 640, offset: 64)
!27 = !DICompositeType(tag: DW_TAG_array_type, baseType: !10, size: 640, elements: !28)
!28 = !{!29}
!29 = !DISubrange(count: 20)
!30 = !DIExpression()
!31 = !DILocation(line: 12, column: 11, scope: !7)
!32 = !DILocation(line: 13, column: 6, scope: !7)
!33 = !DILocation(line: 13, column: 11, scope: !7)
!34 = !DILocation(line: 13, column: 2, scope: !7)
!35 = !DILocation(line: 13, column: 17, scope: !7)
!36 = !DILocation(line: 14, column: 1, scope: !7)
