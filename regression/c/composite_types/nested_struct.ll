; ModuleID = 'nested_struct.c'
source_filename = "nested_struct.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.student = type { i8*, i32, float, %struct.address }
%struct.address = type { i8, i32 }

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !7 {
entry:
  %retval = alloca i32, align 4
  %s = alloca %struct.student, align 8
  %roll_no = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.student* %s, metadata !11, metadata !25), !dbg !26
  call void @llvm.dbg.declare(metadata i32* %roll_no, metadata !27, metadata !25), !dbg !28
  %roll_no1 = getelementptr inbounds %struct.student, %struct.student* %s, i32 0, i32 1, !dbg !29
  store i32 1, i32* %roll_no1, align 8, !dbg !30
  %cgpa = getelementptr inbounds %struct.student, %struct.student* %s, i32 0, i32 2, !dbg !31
  store float 6.500000e+00, float* %cgpa, align 4, !dbg !32
  %addr = getelementptr inbounds %struct.student, %struct.student* %s, i32 0, i32 3, !dbg !33
  %road_no = getelementptr inbounds %struct.address, %struct.address* %addr, i32 0, i32 1, !dbg !34
  store i32 15, i32* %road_no, align 4, !dbg !35
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
!1 = !DIFile(filename: "nested_struct.c", directory: "/home/ubuntu/llvm2goto/regression/c/compositre_types")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final)"}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 11, type: !8, isLocal: false, isDefinition: true, scopeLine: 11, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "s", scope: !7, file: !1, line: 12, type: !12)
!12 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "student", file: !1, line: 5, size: 192, elements: !13)
!13 = !{!14, !17, !18, !20}
!14 = !DIDerivedType(tag: DW_TAG_member, name: "name", scope: !12, file: !1, line: 6, baseType: !15, size: 64)
!15 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !16, size: 64)
!16 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!17 = !DIDerivedType(tag: DW_TAG_member, name: "roll_no", scope: !12, file: !1, line: 7, baseType: !10, size: 32, offset: 64)
!18 = !DIDerivedType(tag: DW_TAG_member, name: "cgpa", scope: !12, file: !1, line: 8, baseType: !19, size: 32, offset: 96)
!19 = !DIBasicType(name: "float", size: 32, encoding: DW_ATE_float)
!20 = !DIDerivedType(tag: DW_TAG_member, name: "addr", scope: !12, file: !1, line: 9, baseType: !21, size: 64, offset: 128)
!21 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "address", file: !1, line: 1, size: 64, elements: !22)
!22 = !{!23, !24}
!23 = !DIDerivedType(tag: DW_TAG_member, name: "colony", scope: !21, file: !1, line: 2, baseType: !16, size: 8)
!24 = !DIDerivedType(tag: DW_TAG_member, name: "road_no", scope: !21, file: !1, line: 3, baseType: !10, size: 32, offset: 32)
!25 = !DIExpression()
!26 = !DILocation(line: 12, column: 17, scope: !7)
!27 = !DILocalVariable(name: "roll_no", scope: !7, file: !1, line: 13, type: !10)
!28 = !DILocation(line: 13, column: 6, scope: !7)
!29 = !DILocation(line: 14, column: 4, scope: !7)
!30 = !DILocation(line: 14, column: 12, scope: !7)
!31 = !DILocation(line: 15, column: 4, scope: !7)
!32 = !DILocation(line: 15, column: 9, scope: !7)
!33 = !DILocation(line: 16, column: 4, scope: !7)
!34 = !DILocation(line: 16, column: 9, scope: !7)
!35 = !DILocation(line: 16, column: 17, scope: !7)
!36 = !DILocation(line: 17, column: 2, scope: !7)
