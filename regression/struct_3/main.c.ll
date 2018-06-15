; ModuleID = 'struct_3/main.c'
source_filename = "struct_3/main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.QUEUE = type { [15 x i32], i32 }

; Function Attrs: noinline nounwind uwtable
define i32 @main() #0 !dbg !6 {
entry:
  %retval = alloca i32, align 4
  %queue = alloca %struct.QUEUE, align 4
  %n = alloca i32, align 4
  %i = alloca i32, align 4
  %sum = alloca i32, align 4
  %i4 = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.QUEUE* %queue, metadata !10, metadata !19), !dbg !20
  call void @llvm.dbg.declare(metadata i32* %n, metadata !21, metadata !19), !dbg !22
  %0 = load i32, i32* %n, align 4, !dbg !23
  %cmp = icmp slt i32 %0, 15, !dbg !25
  br i1 %cmp, label %land.lhs.true, label %if.end, !dbg !26

land.lhs.true:                                    ; preds = %entry
  %1 = load i32, i32* %n, align 4, !dbg !27
  %cmp1 = icmp sgt i32 %1, 0, !dbg !29
  br i1 %cmp1, label %if.then, label %if.end, !dbg !30

if.then:                                          ; preds = %land.lhs.true
  call void @llvm.dbg.declare(metadata i32* %i, metadata !32, metadata !19), !dbg !35
  store i32 0, i32* %i, align 4, !dbg !35
  br label %for.cond, !dbg !36

for.cond:                                         ; preds = %for.inc, %if.then
  %2 = load i32, i32* %i, align 4, !dbg !37
  %3 = load i32, i32* %n, align 4, !dbg !40
  %cmp2 = icmp slt i32 %2, %3, !dbg !41
  br i1 %cmp2, label %for.body, label %for.end, !dbg !42

for.body:                                         ; preds = %for.cond
  %4 = load i32, i32* %i, align 4, !dbg !44
  %data = getelementptr inbounds %struct.QUEUE, %struct.QUEUE* %queue, i32 0, i32 0, !dbg !46
  %5 = load i32, i32* %i, align 4, !dbg !47
  %idxprom = sext i32 %5 to i64, !dbg !48
  %arrayidx = getelementptr inbounds [15 x i32], [15 x i32]* %data, i64 0, i64 %idxprom, !dbg !48
  store i32 %4, i32* %arrayidx, align 4, !dbg !49
  %size = getelementptr inbounds %struct.QUEUE, %struct.QUEUE* %queue, i32 0, i32 1, !dbg !50
  %6 = load i32, i32* %size, align 4, !dbg !51
  %inc = add nsw i32 %6, 1, !dbg !51
  store i32 %inc, i32* %size, align 4, !dbg !51
  br label %for.inc, !dbg !52

for.inc:                                          ; preds = %for.body
  %7 = load i32, i32* %i, align 4, !dbg !53
  %inc3 = add nsw i32 %7, 1, !dbg !53
  store i32 %inc3, i32* %i, align 4, !dbg !53
  br label %for.cond, !dbg !55, !llvm.loop !56

for.end:                                          ; preds = %for.cond
  call void @llvm.dbg.declare(metadata i32* %sum, metadata !59, metadata !19), !dbg !60
  store i32 0, i32* %sum, align 4, !dbg !60
  call void @llvm.dbg.declare(metadata i32* %i4, metadata !61, metadata !19), !dbg !63
  store i32 0, i32* %i4, align 4, !dbg !63
  br label %for.cond5, !dbg !64

for.cond5:                                        ; preds = %for.inc11, %for.end
  %8 = load i32, i32* %i4, align 4, !dbg !65
  %9 = load i32, i32* %n, align 4, !dbg !68
  %cmp6 = icmp slt i32 %8, %9, !dbg !69
  br i1 %cmp6, label %for.body7, label %for.end13, !dbg !70

for.body7:                                        ; preds = %for.cond5
  %data8 = getelementptr inbounds %struct.QUEUE, %struct.QUEUE* %queue, i32 0, i32 0, !dbg !72
  %10 = load i32, i32* %i4, align 4, !dbg !74
  %idxprom9 = sext i32 %10 to i64, !dbg !75
  %arrayidx10 = getelementptr inbounds [15 x i32], [15 x i32]* %data8, i64 0, i64 %idxprom9, !dbg !75
  %11 = load i32, i32* %arrayidx10, align 4, !dbg !75
  %12 = load i32, i32* %sum, align 4, !dbg !76
  %add = add nsw i32 %12, %11, !dbg !76
  store i32 %add, i32* %sum, align 4, !dbg !76
  br label %for.inc11, !dbg !77

for.inc11:                                        ; preds = %for.body7
  %13 = load i32, i32* %i4, align 4, !dbg !78
  %inc12 = add nsw i32 %13, 1, !dbg !78
  store i32 %inc12, i32* %i4, align 4, !dbg !78
  br label %for.cond5, !dbg !80, !llvm.loop !81

for.end13:                                        ; preds = %for.cond5
  %14 = load i32, i32* %sum, align 4, !dbg !84
  %15 = load i32, i32* %n, align 4, !dbg !85
  %sub = sub nsw i32 %15, 1, !dbg !86
  %16 = load i32, i32* %n, align 4, !dbg !87
  %mul = mul nsw i32 %sub, %16, !dbg !88
  %div = sdiv i32 %mul, 2, !dbg !89
  %cmp14 = icmp eq i32 %14, %div, !dbg !90
  %conv = zext i1 %cmp14 to i32, !dbg !90
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !91
  br label %if.end, !dbg !92

if.end:                                           ; preds = %for.end13, %land.lhs.true, %entry
  ret i32 0, !dbg !93
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i32 @assert(...) #2

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4}
!llvm.ident = !{!5}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.0 (trunk 295264)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "struct_3/main.c", directory: "/home/rasika/llvm2goto/llvm2goto-regression-master")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{!"clang version 5.0.0 (trunk 295264)"}
!6 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 13, type: !7, isLocal: false, isDefinition: true, scopeLine: 14, isOptimized: false, unit: !0, variables: !2)
!7 = !DISubroutineType(types: !8)
!8 = !{!9}
!9 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!10 = !DILocalVariable(name: "queue", scope: !6, file: !1, line: 15, type: !11)
!11 = !DIDerivedType(tag: DW_TAG_typedef, name: "QUEUE", file: !1, line: 11, baseType: !12)
!12 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "QUEUE", file: !1, line: 5, size: 512, elements: !13)
!13 = !{!14, !18}
!14 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !12, file: !1, line: 7, baseType: !15, size: 480)
!15 = !DICompositeType(tag: DW_TAG_array_type, baseType: !9, size: 480, elements: !16)
!16 = !{!17}
!17 = !DISubrange(count: 15)
!18 = !DIDerivedType(tag: DW_TAG_member, name: "size", scope: !12, file: !1, line: 8, baseType: !9, size: 32, offset: 480)
!19 = !DIExpression()
!20 = !DILocation(line: 15, column: 8, scope: !6)
!21 = !DILocalVariable(name: "n", scope: !6, file: !1, line: 16, type: !9)
!22 = !DILocation(line: 16, column: 6, scope: !6)
!23 = !DILocation(line: 20, column: 5, scope: !24)
!24 = distinct !DILexicalBlock(scope: !6, file: !1, line: 20, column: 5)
!25 = !DILocation(line: 20, column: 6, scope: !24)
!26 = !DILocation(line: 20, column: 9, scope: !24)
!27 = !DILocation(line: 20, column: 12, scope: !28)
!28 = !DILexicalBlockFile(scope: !24, file: !1, discriminator: 2)
!29 = !DILocation(line: 20, column: 13, scope: !28)
!30 = !DILocation(line: 20, column: 5, scope: !31)
!31 = !DILexicalBlockFile(scope: !6, file: !1, discriminator: 2)
!32 = !DILocalVariable(name: "i", scope: !33, file: !1, line: 22, type: !9)
!33 = distinct !DILexicalBlock(scope: !34, file: !1, line: 22, column: 3)
!34 = distinct !DILexicalBlock(scope: !24, file: !1, line: 21, column: 2)
!35 = !DILocation(line: 22, column: 11, scope: !33)
!36 = !DILocation(line: 22, column: 7, scope: !33)
!37 = !DILocation(line: 22, column: 17, scope: !38)
!38 = !DILexicalBlockFile(scope: !39, file: !1, discriminator: 2)
!39 = distinct !DILexicalBlock(scope: !33, file: !1, line: 22, column: 3)
!40 = !DILocation(line: 22, column: 19, scope: !38)
!41 = !DILocation(line: 22, column: 18, scope: !38)
!42 = !DILocation(line: 22, column: 3, scope: !43)
!43 = !DILexicalBlockFile(scope: !33, file: !1, discriminator: 2)
!44 = !DILocation(line: 24, column: 20, scope: !45)
!45 = distinct !DILexicalBlock(scope: !39, file: !1, line: 23, column: 3)
!46 = !DILocation(line: 24, column: 10, scope: !45)
!47 = !DILocation(line: 24, column: 15, scope: !45)
!48 = !DILocation(line: 24, column: 4, scope: !45)
!49 = !DILocation(line: 24, column: 18, scope: !45)
!50 = !DILocation(line: 25, column: 12, scope: !45)
!51 = !DILocation(line: 25, column: 4, scope: !45)
!52 = !DILocation(line: 26, column: 3, scope: !45)
!53 = !DILocation(line: 22, column: 24, scope: !54)
!54 = !DILexicalBlockFile(scope: !39, file: !1, discriminator: 4)
!55 = !DILocation(line: 22, column: 3, scope: !54)
!56 = distinct !{!56, !57, !58}
!57 = !DILocation(line: 22, column: 3, scope: !33)
!58 = !DILocation(line: 26, column: 3, scope: !33)
!59 = !DILocalVariable(name: "sum", scope: !34, file: !1, line: 28, type: !9)
!60 = !DILocation(line: 28, column: 7, scope: !34)
!61 = !DILocalVariable(name: "i", scope: !62, file: !1, line: 30, type: !9)
!62 = distinct !DILexicalBlock(scope: !34, file: !1, line: 30, column: 3)
!63 = !DILocation(line: 30, column: 11, scope: !62)
!64 = !DILocation(line: 30, column: 7, scope: !62)
!65 = !DILocation(line: 30, column: 17, scope: !66)
!66 = !DILexicalBlockFile(scope: !67, file: !1, discriminator: 2)
!67 = distinct !DILexicalBlock(scope: !62, file: !1, line: 30, column: 3)
!68 = !DILocation(line: 30, column: 19, scope: !66)
!69 = !DILocation(line: 30, column: 18, scope: !66)
!70 = !DILocation(line: 30, column: 3, scope: !71)
!71 = !DILexicalBlockFile(scope: !62, file: !1, discriminator: 2)
!72 = !DILocation(line: 32, column: 17, scope: !73)
!73 = distinct !DILexicalBlock(scope: !67, file: !1, line: 31, column: 3)
!74 = !DILocation(line: 32, column: 22, scope: !73)
!75 = !DILocation(line: 32, column: 11, scope: !73)
!76 = !DILocation(line: 32, column: 8, scope: !73)
!77 = !DILocation(line: 33, column: 3, scope: !73)
!78 = !DILocation(line: 30, column: 24, scope: !79)
!79 = !DILexicalBlockFile(scope: !67, file: !1, discriminator: 4)
!80 = !DILocation(line: 30, column: 3, scope: !79)
!81 = distinct !{!81, !82, !83}
!82 = !DILocation(line: 30, column: 3, scope: !62)
!83 = !DILocation(line: 33, column: 3, scope: !62)
!84 = !DILocation(line: 35, column: 10, scope: !34)
!85 = !DILocation(line: 35, column: 19, scope: !34)
!86 = !DILocation(line: 35, column: 20, scope: !34)
!87 = !DILocation(line: 35, column: 24, scope: !34)
!88 = !DILocation(line: 35, column: 23, scope: !34)
!89 = !DILocation(line: 35, column: 26, scope: !34)
!90 = !DILocation(line: 35, column: 14, scope: !34)
!91 = !DILocation(line: 35, column: 3, scope: !34)
!92 = !DILocation(line: 36, column: 2, scope: !34)
!93 = !DILocation(line: 38, column: 2, scope: !6)
