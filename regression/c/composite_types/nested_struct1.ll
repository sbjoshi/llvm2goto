; ModuleID = 'nested_struct1.c'
source_filename = "nested_struct1.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.student = type { %struct.person, i32, float }
%struct.person = type { float, %struct.address }
%struct.address = type { float, i32 }

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !7 {
entry:
  %retval = alloca i32, align 4
  %s = alloca %struct.student, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.student* %s, metadata !11, metadata !26), !dbg !27
  %roll_no = getelementptr inbounds %struct.student, %struct.student* %s, i32 0, i32 1, !dbg !28
  store i32 1, i32* %roll_no, align 4, !dbg !29
  %cgpa = getelementptr inbounds %struct.student, %struct.student* %s, i32 0, i32 2, !dbg !30
  store float 6.500000e+00, float* %cgpa, align 4, !dbg !31
  %p = getelementptr inbounds %struct.student, %struct.student* %s, i32 0, i32 0, !dbg !32
  %addr = getelementptr inbounds %struct.person, %struct.person* %p, i32 0, i32 1, !dbg !33
  %streat_no = getelementptr inbounds %struct.address, %struct.address* %addr, i32 0, i32 1, !dbg !34
  store i32 20, i32* %streat_no, align 4, !dbg !35
  %p1 = getelementptr inbounds %struct.student, %struct.student* %s, i32 0, i32 0, !dbg !36
  %addr2 = getelementptr inbounds %struct.person, %struct.person* %p1, i32 0, i32 1, !dbg !37
  %streat_no3 = getelementptr inbounds %struct.address, %struct.address* %addr2, i32 0, i32 1, !dbg !38
  %0 = load i32, i32* %streat_no3, align 4, !dbg !38
  %cmp = icmp eq i32 %0, 20, !dbg !39
  %conv = zext i1 %cmp to i32, !dbg !39
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !40
  ret i32 0, !dbg !41
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i32 @assert(...) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "nested_struct1.c", directory: "/home/ubuntu/llvm2goto/regression/c/compositre_types")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final)"}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 14, type: !8, isLocal: false, isDefinition: true, scopeLine: 14, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "s", scope: !7, file: !1, line: 15, type: !12)
!12 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "student", file: !1, line: 9, size: 160, elements: !13)
!13 = !{!14, !24, !25}
!14 = !DIDerivedType(tag: DW_TAG_member, name: "p", scope: !12, file: !1, line: 10, baseType: !15, size: 96)
!15 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "person", file: !1, line: 5, size: 96, elements: !16)
!16 = !{!17, !19}
!17 = !DIDerivedType(tag: DW_TAG_member, name: "name", scope: !15, file: !1, line: 6, baseType: !18, size: 32)
!18 = !DIBasicType(name: "float", size: 32, encoding: DW_ATE_float)
!19 = !DIDerivedType(tag: DW_TAG_member, name: "addr", scope: !15, file: !1, line: 7, baseType: !20, size: 64, offset: 32)
!20 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "address", file: !1, line: 1, size: 64, elements: !21)
!21 = !{!22, !23}
!22 = !DIDerivedType(tag: DW_TAG_member, name: "colony", scope: !20, file: !1, line: 2, baseType: !18, size: 32)
!23 = !DIDerivedType(tag: DW_TAG_member, name: "streat_no", scope: !20, file: !1, line: 3, baseType: !10, size: 32, offset: 32)
!24 = !DIDerivedType(tag: DW_TAG_member, name: "roll_no", scope: !12, file: !1, line: 11, baseType: !10, size: 32, offset: 96)
!25 = !DIDerivedType(tag: DW_TAG_member, name: "cgpa", scope: !12, file: !1, line: 12, baseType: !18, size: 32, offset: 128)
!26 = !DIExpression()
!27 = !DILocation(line: 15, column: 17, scope: !7)
!28 = !DILocation(line: 17, column: 4, scope: !7)
!29 = !DILocation(line: 17, column: 12, scope: !7)
!30 = !DILocation(line: 18, column: 4, scope: !7)
!31 = !DILocation(line: 18, column: 9, scope: !7)
!32 = !DILocation(line: 20, column: 4, scope: !7)
!33 = !DILocation(line: 20, column: 6, scope: !7)
!34 = !DILocation(line: 20, column: 11, scope: !7)
!35 = !DILocation(line: 20, column: 21, scope: !7)
!36 = !DILocation(line: 21, column: 11, scope: !7)
!37 = !DILocation(line: 21, column: 13, scope: !7)
!38 = !DILocation(line: 21, column: 18, scope: !7)
!39 = !DILocation(line: 21, column: 28, scope: !7)
!40 = !DILocation(line: 21, column: 2, scope: !7)
!41 = !DILocation(line: 22, column: 2, scope: !7)
