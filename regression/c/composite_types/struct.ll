; ModuleID = 'struct.c'
source_filename = "struct.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.student = type { i8*, i32 }

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !7 {
entry:
  %retval = alloca i32, align 4
  %s = alloca %struct.student, align 8
  %roll_no = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.student* %s, metadata !11, metadata !18), !dbg !19
  call void @llvm.dbg.declare(metadata i32* %roll_no, metadata !20, metadata !18), !dbg !21
  %roll_no1 = getelementptr inbounds %struct.student, %struct.student* %s, i32 0, i32 1, !dbg !22
  store i32 1, i32* %roll_no1, align 8, !dbg !23
  %roll_no2 = getelementptr inbounds %struct.student, %struct.student* %s, i32 0, i32 1, !dbg !24
  %0 = load i32, i32* %roll_no2, align 8, !dbg !24
  %cmp = icmp eq i32 %0, 1, !dbg !25
  %conv = zext i1 %cmp to i32, !dbg !25
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !26
  %roll_no3 = getelementptr inbounds %struct.student, %struct.student* %s, i32 0, i32 1, !dbg !27
  %1 = load i32, i32* %roll_no3, align 8, !dbg !27
  %cmp4 = icmp eq i32 %1, 2, !dbg !28
  %conv5 = zext i1 %cmp4 to i32, !dbg !28
  %call6 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv5), !dbg !29
  ret i32 0, !dbg !30
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
!1 = !DIFile(filename: "struct.c", directory: "/home/ubuntu/llvm2goto/regression/c/composite_types")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final)"}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 6, type: !8, isLocal: false, isDefinition: true, scopeLine: 6, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "s", scope: !7, file: !1, line: 7, type: !12)
!12 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "student", file: !1, line: 1, size: 128, elements: !13)
!13 = !{!14, !17}
!14 = !DIDerivedType(tag: DW_TAG_member, name: "name", scope: !12, file: !1, line: 2, baseType: !15, size: 64)
!15 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !16, size: 64)
!16 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!17 = !DIDerivedType(tag: DW_TAG_member, name: "roll_no", scope: !12, file: !1, line: 3, baseType: !10, size: 32, offset: 64)
!18 = !DIExpression()
!19 = !DILocation(line: 7, column: 17, scope: !7)
!20 = !DILocalVariable(name: "roll_no", scope: !7, file: !1, line: 8, type: !10)
!21 = !DILocation(line: 8, column: 6, scope: !7)
!22 = !DILocation(line: 9, column: 4, scope: !7)
!23 = !DILocation(line: 9, column: 12, scope: !7)
!24 = !DILocation(line: 11, column: 11, scope: !7)
!25 = !DILocation(line: 11, column: 19, scope: !7)
!26 = !DILocation(line: 11, column: 2, scope: !7)
!27 = !DILocation(line: 12, column: 11, scope: !7)
!28 = !DILocation(line: 12, column: 19, scope: !7)
!29 = !DILocation(line: 12, column: 2, scope: !7)
!30 = !DILocation(line: 13, column: 2, scope: !7)
