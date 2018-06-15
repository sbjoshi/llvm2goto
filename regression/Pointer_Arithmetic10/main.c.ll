; ModuleID = 'Pointer_Arithmetic10/main.c'
source_filename = "Pointer_Arithmetic10/main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.A = type { [4 x i8] }

; Function Attrs: noinline nounwind uwtable
define void @func(%struct.A* %ptr) #0 !dbg !6 {
entry:
  %ptr.addr = alloca %struct.A*, align 8
  %i = alloca i32, align 4
  store %struct.A* %ptr, %struct.A** %ptr.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.A** %ptr.addr, metadata !18, metadata !19), !dbg !20
  call void @llvm.dbg.declare(metadata i32* %i, metadata !21, metadata !19), !dbg !23
  store i32 1, i32* %i, align 4, !dbg !23
  %0 = load %struct.A*, %struct.A** %ptr.addr, align 8, !dbg !24
  %1 = load i32, i32* %i, align 4, !dbg !25
  %idxprom = sext i32 %1 to i64, !dbg !24
  %arrayidx = getelementptr inbounds %struct.A, %struct.A* %0, i64 %idxprom, !dbg !24
  %array = getelementptr inbounds %struct.A, %struct.A* %arrayidx, i32 0, i32 0, !dbg !26
  %arrayidx1 = getelementptr inbounds [4 x i8], [4 x i8]* %array, i64 0, i64 0, !dbg !24
  %2 = load i8, i8* %arrayidx1, align 1, !dbg !24
  %conv = zext i8 %2 to i32, !dbg !24
  %cmp = icmp eq i32 %conv, 2, !dbg !27
  %conv2 = zext i1 %cmp to i32, !dbg !27
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv2), !dbg !28
  ret void, !dbg !29
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i32 @assert(...) #2

; Function Attrs: noinline nounwind uwtable
define i32 @main() #0 !dbg !30 {
entry:
  %retval = alloca i32, align 4
  %a = alloca [2 x %struct.A], align 1
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata [2 x %struct.A]* %a, metadata !33, metadata !19), !dbg !37
  %arrayidx = getelementptr inbounds [2 x %struct.A], [2 x %struct.A]* %a, i64 0, i64 1, !dbg !38
  %array = getelementptr inbounds %struct.A, %struct.A* %arrayidx, i32 0, i32 0, !dbg !39
  %arrayidx1 = getelementptr inbounds [4 x i8], [4 x i8]* %array, i64 0, i64 0, !dbg !38
  store i8 2, i8* %arrayidx1, align 1, !dbg !40
  %arraydecay = getelementptr inbounds [2 x %struct.A], [2 x %struct.A]* %a, i32 0, i32 0, !dbg !41
  call void @func(%struct.A* %arraydecay), !dbg !42
  ret i32 0, !dbg !43
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4}
!llvm.ident = !{!5}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.0 (trunk 295264)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "Pointer_Arithmetic10/main.c", directory: "/home/rasika/llvm2goto/llvm2goto-regression-master")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{!"clang version 5.0.0 (trunk 295264)"}
!6 = distinct !DISubprogram(name: "func", scope: !1, file: !1, line: 6, type: !7, isLocal: false, isDefinition: true, scopeLine: 7, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!7 = !DISubroutineType(types: !8)
!8 = !{null, !9}
!9 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !10, size: 64)
!10 = !DIDerivedType(tag: DW_TAG_typedef, name: "A", file: !1, line: 4, baseType: !11)
!11 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !1, line: 1, size: 32, elements: !12)
!12 = !{!13}
!13 = !DIDerivedType(tag: DW_TAG_member, name: "array", scope: !11, file: !1, line: 3, baseType: !14, size: 32)
!14 = !DICompositeType(tag: DW_TAG_array_type, baseType: !15, size: 32, elements: !16)
!15 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!16 = !{!17}
!17 = !DISubrange(count: 4)
!18 = !DILocalVariable(name: "ptr", arg: 1, scope: !6, file: !1, line: 6, type: !9)
!19 = !DIExpression()
!20 = !DILocation(line: 6, column: 14, scope: !6)
!21 = !DILocalVariable(name: "i", scope: !6, file: !1, line: 8, type: !22)
!22 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!23 = !DILocation(line: 8, column: 7, scope: !6)
!24 = !DILocation(line: 9, column: 10, scope: !6)
!25 = !DILocation(line: 9, column: 14, scope: !6)
!26 = !DILocation(line: 9, column: 17, scope: !6)
!27 = !DILocation(line: 9, column: 26, scope: !6)
!28 = !DILocation(line: 9, column: 3, scope: !6)
!29 = !DILocation(line: 10, column: 1, scope: !6)
!30 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 12, type: !31, isLocal: false, isDefinition: true, scopeLine: 13, isOptimized: false, unit: !0, variables: !2)
!31 = !DISubroutineType(types: !32)
!32 = !{!22}
!33 = !DILocalVariable(name: "a", scope: !30, file: !1, line: 14, type: !34)
!34 = !DICompositeType(tag: DW_TAG_array_type, baseType: !10, size: 64, elements: !35)
!35 = !{!36}
!36 = !DISubrange(count: 2)
!37 = !DILocation(line: 14, column: 5, scope: !30)
!38 = !DILocation(line: 15, column: 3, scope: !30)
!39 = !DILocation(line: 15, column: 8, scope: !30)
!40 = !DILocation(line: 15, column: 17, scope: !30)
!41 = !DILocation(line: 16, column: 8, scope: !30)
!42 = !DILocation(line: 16, column: 3, scope: !30)
!43 = !DILocation(line: 17, column: 3, scope: !30)
