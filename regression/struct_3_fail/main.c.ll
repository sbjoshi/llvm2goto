; ModuleID = 'struct_3_fail/main.c'
source_filename = "struct_3_fail/main.c"
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
  %i3 = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.QUEUE* %queue, metadata !10, metadata !19), !dbg !20
  call void @llvm.dbg.declare(metadata i32* %n, metadata !21, metadata !19), !dbg !22
  %0 = load i32, i32* %n, align 4, !dbg !23
  %cmp = icmp slt i32 %0, 15, !dbg !25
  br i1 %cmp, label %if.then, label %if.end, !dbg !26

if.then:                                          ; preds = %entry
  call void @llvm.dbg.declare(metadata i32* %i, metadata !27, metadata !19), !dbg !30
  store i32 0, i32* %i, align 4, !dbg !30
  br label %for.cond, !dbg !31

for.cond:                                         ; preds = %for.inc, %if.then
  %1 = load i32, i32* %i, align 4, !dbg !32
  %2 = load i32, i32* %n, align 4, !dbg !35
  %cmp1 = icmp slt i32 %1, %2, !dbg !36
  br i1 %cmp1, label %for.body, label %for.end, !dbg !37

for.body:                                         ; preds = %for.cond
  %3 = load i32, i32* %i, align 4, !dbg !39
  %data = getelementptr inbounds %struct.QUEUE, %struct.QUEUE* %queue, i32 0, i32 0, !dbg !41
  %4 = load i32, i32* %i, align 4, !dbg !42
  %idxprom = sext i32 %4 to i64, !dbg !43
  %arrayidx = getelementptr inbounds [15 x i32], [15 x i32]* %data, i64 0, i64 %idxprom, !dbg !43
  store i32 %3, i32* %arrayidx, align 4, !dbg !44
  %size = getelementptr inbounds %struct.QUEUE, %struct.QUEUE* %queue, i32 0, i32 1, !dbg !45
  %5 = load i32, i32* %size, align 4, !dbg !46
  %inc = add nsw i32 %5, 1, !dbg !46
  store i32 %inc, i32* %size, align 4, !dbg !46
  br label %for.inc, !dbg !47

for.inc:                                          ; preds = %for.body
  %6 = load i32, i32* %i, align 4, !dbg !48
  %inc2 = add nsw i32 %6, 1, !dbg !48
  store i32 %inc2, i32* %i, align 4, !dbg !48
  br label %for.cond, !dbg !50, !llvm.loop !51

for.end:                                          ; preds = %for.cond
  call void @llvm.dbg.declare(metadata i32* %sum, metadata !54, metadata !19), !dbg !55
  store i32 0, i32* %sum, align 4, !dbg !55
  call void @llvm.dbg.declare(metadata i32* %i3, metadata !56, metadata !19), !dbg !58
  store i32 0, i32* %i3, align 4, !dbg !58
  br label %for.cond4, !dbg !59

for.cond4:                                        ; preds = %for.inc10, %for.end
  %7 = load i32, i32* %i3, align 4, !dbg !60
  %8 = load i32, i32* %n, align 4, !dbg !63
  %cmp5 = icmp slt i32 %7, %8, !dbg !64
  br i1 %cmp5, label %for.body6, label %for.end12, !dbg !65

for.body6:                                        ; preds = %for.cond4
  %data7 = getelementptr inbounds %struct.QUEUE, %struct.QUEUE* %queue, i32 0, i32 0, !dbg !67
  %9 = load i32, i32* %i3, align 4, !dbg !69
  %idxprom8 = sext i32 %9 to i64, !dbg !70
  %arrayidx9 = getelementptr inbounds [15 x i32], [15 x i32]* %data7, i64 0, i64 %idxprom8, !dbg !70
  %10 = load i32, i32* %arrayidx9, align 4, !dbg !70
  %11 = load i32, i32* %sum, align 4, !dbg !71
  %add = add nsw i32 %11, %10, !dbg !71
  store i32 %add, i32* %sum, align 4, !dbg !71
  br label %for.inc10, !dbg !72

for.inc10:                                        ; preds = %for.body6
  %12 = load i32, i32* %i3, align 4, !dbg !73
  %inc11 = add nsw i32 %12, 1, !dbg !73
  store i32 %inc11, i32* %i3, align 4, !dbg !73
  br label %for.cond4, !dbg !75, !llvm.loop !76

for.end12:                                        ; preds = %for.cond4
  %13 = load i32, i32* %sum, align 4, !dbg !79
  %14 = load i32, i32* %n, align 4, !dbg !80
  %sub = sub nsw i32 %14, 1, !dbg !81
  %15 = load i32, i32* %n, align 4, !dbg !82
  %mul = mul nsw i32 %sub, %15, !dbg !83
  %div = sdiv i32 %mul, 2, !dbg !84
  %cmp13 = icmp eq i32 %13, %div, !dbg !85
  %conv = zext i1 %cmp13 to i32, !dbg !85
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !86
  br label %if.end, !dbg !87

if.end:                                           ; preds = %for.end12, %entry
  ret i32 0, !dbg !88
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
!1 = !DIFile(filename: "struct_3_fail/main.c", directory: "/home/rasika/llvm2goto/llvm2goto-regression-master")
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
!26 = !DILocation(line: 20, column: 5, scope: !6)
!27 = !DILocalVariable(name: "i", scope: !28, file: !1, line: 22, type: !9)
!28 = distinct !DILexicalBlock(scope: !29, file: !1, line: 22, column: 3)
!29 = distinct !DILexicalBlock(scope: !24, file: !1, line: 21, column: 2)
!30 = !DILocation(line: 22, column: 11, scope: !28)
!31 = !DILocation(line: 22, column: 7, scope: !28)
!32 = !DILocation(line: 22, column: 17, scope: !33)
!33 = !DILexicalBlockFile(scope: !34, file: !1, discriminator: 2)
!34 = distinct !DILexicalBlock(scope: !28, file: !1, line: 22, column: 3)
!35 = !DILocation(line: 22, column: 19, scope: !33)
!36 = !DILocation(line: 22, column: 18, scope: !33)
!37 = !DILocation(line: 22, column: 3, scope: !38)
!38 = !DILexicalBlockFile(scope: !28, file: !1, discriminator: 2)
!39 = !DILocation(line: 24, column: 20, scope: !40)
!40 = distinct !DILexicalBlock(scope: !34, file: !1, line: 23, column: 3)
!41 = !DILocation(line: 24, column: 10, scope: !40)
!42 = !DILocation(line: 24, column: 15, scope: !40)
!43 = !DILocation(line: 24, column: 4, scope: !40)
!44 = !DILocation(line: 24, column: 18, scope: !40)
!45 = !DILocation(line: 25, column: 12, scope: !40)
!46 = !DILocation(line: 25, column: 4, scope: !40)
!47 = !DILocation(line: 26, column: 3, scope: !40)
!48 = !DILocation(line: 22, column: 24, scope: !49)
!49 = !DILexicalBlockFile(scope: !34, file: !1, discriminator: 4)
!50 = !DILocation(line: 22, column: 3, scope: !49)
!51 = distinct !{!51, !52, !53}
!52 = !DILocation(line: 22, column: 3, scope: !28)
!53 = !DILocation(line: 26, column: 3, scope: !28)
!54 = !DILocalVariable(name: "sum", scope: !29, file: !1, line: 28, type: !9)
!55 = !DILocation(line: 28, column: 7, scope: !29)
!56 = !DILocalVariable(name: "i", scope: !57, file: !1, line: 30, type: !9)
!57 = distinct !DILexicalBlock(scope: !29, file: !1, line: 30, column: 3)
!58 = !DILocation(line: 30, column: 11, scope: !57)
!59 = !DILocation(line: 30, column: 7, scope: !57)
!60 = !DILocation(line: 30, column: 17, scope: !61)
!61 = !DILexicalBlockFile(scope: !62, file: !1, discriminator: 2)
!62 = distinct !DILexicalBlock(scope: !57, file: !1, line: 30, column: 3)
!63 = !DILocation(line: 30, column: 19, scope: !61)
!64 = !DILocation(line: 30, column: 18, scope: !61)
!65 = !DILocation(line: 30, column: 3, scope: !66)
!66 = !DILexicalBlockFile(scope: !57, file: !1, discriminator: 2)
!67 = !DILocation(line: 32, column: 17, scope: !68)
!68 = distinct !DILexicalBlock(scope: !62, file: !1, line: 31, column: 3)
!69 = !DILocation(line: 32, column: 22, scope: !68)
!70 = !DILocation(line: 32, column: 11, scope: !68)
!71 = !DILocation(line: 32, column: 8, scope: !68)
!72 = !DILocation(line: 33, column: 3, scope: !68)
!73 = !DILocation(line: 30, column: 24, scope: !74)
!74 = !DILexicalBlockFile(scope: !62, file: !1, discriminator: 4)
!75 = !DILocation(line: 30, column: 3, scope: !74)
!76 = distinct !{!76, !77, !78}
!77 = !DILocation(line: 30, column: 3, scope: !57)
!78 = !DILocation(line: 33, column: 3, scope: !57)
!79 = !DILocation(line: 35, column: 10, scope: !29)
!80 = !DILocation(line: 35, column: 19, scope: !29)
!81 = !DILocation(line: 35, column: 20, scope: !29)
!82 = !DILocation(line: 35, column: 24, scope: !29)
!83 = !DILocation(line: 35, column: 23, scope: !29)
!84 = !DILocation(line: 35, column: 26, scope: !29)
!85 = !DILocation(line: 35, column: 14, scope: !29)
!86 = !DILocation(line: 35, column: 3, scope: !29)
!87 = !DILocation(line: 36, column: 2, scope: !29)
!88 = !DILocation(line: 38, column: 2, scope: !6)
