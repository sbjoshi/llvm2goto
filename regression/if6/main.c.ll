; ModuleID = 'if6/main.c'
source_filename = "if6/main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define i32 @main() #0 !dbg !6 {
entry:
  %retval = alloca i32, align 4
  %x = alloca i32, align 4
  %x_prev = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %x, metadata !10, metadata !11), !dbg !12
  call void @llvm.dbg.declare(metadata i32* %x_prev, metadata !13, metadata !11), !dbg !14
  %0 = load i32, i32* %x, align 4, !dbg !15
  store i32 %0, i32* %x_prev, align 4, !dbg !14
  %1 = load i32, i32* %x, align 4, !dbg !16
  %cmp = icmp sge i32 %1, 0, !dbg !18
  br i1 %cmp, label %land.lhs.true, label %if.end13, !dbg !19

land.lhs.true:                                    ; preds = %entry
  %2 = load i32, i32* %x_prev, align 4, !dbg !20
  %cmp1 = icmp slt i32 %2, 2147483643, !dbg !22
  br i1 %cmp1, label %if.then, label %if.end13, !dbg !23

if.then:                                          ; preds = %land.lhs.true
  %3 = load i32, i32* %x, align 4, !dbg !25
  %inc = add nsw i32 %3, 1, !dbg !25
  store i32 %inc, i32* %x, align 4, !dbg !25
  %4 = load i32, i32* %x, align 4, !dbg !27
  %cmp2 = icmp sge i32 %4, 1, !dbg !29
  br i1 %cmp2, label %if.then3, label %if.end12, !dbg !30

if.then3:                                         ; preds = %if.then
  %5 = load i32, i32* %x, align 4, !dbg !31
  %inc4 = add nsw i32 %5, 1, !dbg !31
  store i32 %inc4, i32* %x, align 4, !dbg !31
  %6 = load i32, i32* %x, align 4, !dbg !33
  %cmp5 = icmp sge i32 %6, 2, !dbg !35
  br i1 %cmp5, label %if.then6, label %if.end11, !dbg !36

if.then6:                                         ; preds = %if.then3
  %7 = load i32, i32* %x, align 4, !dbg !37
  %inc7 = add nsw i32 %7, 1, !dbg !37
  store i32 %inc7, i32* %x, align 4, !dbg !37
  %8 = load i32, i32* %x, align 4, !dbg !39
  %cmp8 = icmp sge i32 %8, 3, !dbg !41
  br i1 %cmp8, label %if.then9, label %if.end, !dbg !42

if.then9:                                         ; preds = %if.then6
  %9 = load i32, i32* %x, align 4, !dbg !43
  %inc10 = add nsw i32 %9, 1, !dbg !43
  store i32 %inc10, i32* %x, align 4, !dbg !43
  br label %if.end, !dbg !44

if.end:                                           ; preds = %if.then9, %if.then6
  br label %if.end11, !dbg !45

if.end11:                                         ; preds = %if.end, %if.then3
  br label %if.end12, !dbg !46

if.end12:                                         ; preds = %if.end11, %if.then
  br label %if.end13, !dbg !47

if.end13:                                         ; preds = %if.end12, %land.lhs.true, %entry
  %10 = load i32, i32* %x_prev, align 4, !dbg !48
  %cmp14 = icmp sge i32 %10, 0, !dbg !49
  br i1 %cmp14, label %land.lhs.true15, label %lor.rhs, !dbg !50

land.lhs.true15:                                  ; preds = %if.end13
  %11 = load i32, i32* %x, align 4, !dbg !51
  %cmp16 = icmp sge i32 %11, 4, !dbg !52
  br i1 %cmp16, label %lor.end, label %lor.rhs, !dbg !53

lor.rhs:                                          ; preds = %land.lhs.true15, %if.end13
  %12 = load i32, i32* %x_prev, align 4, !dbg !54
  %cmp17 = icmp slt i32 %12, 0, !dbg !56
  br i1 %cmp17, label %land.rhs, label %land.end, !dbg !57

land.rhs:                                         ; preds = %lor.rhs
  %13 = load i32, i32* %x_prev, align 4, !dbg !58
  %14 = load i32, i32* %x, align 4, !dbg !60
  %cmp18 = icmp eq i32 %13, %14, !dbg !61
  br label %land.end

land.end:                                         ; preds = %land.rhs, %lor.rhs
  %15 = phi i1 [ false, %lor.rhs ], [ %cmp18, %land.rhs ]
  br label %lor.end, !dbg !62

lor.end:                                          ; preds = %land.end, %land.lhs.true15
  %16 = phi i1 [ true, %land.lhs.true15 ], [ %15, %land.end ]
  %lor.ext = zext i1 %16 to i32, !dbg !64
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %lor.ext), !dbg !66
  ret i32 0, !dbg !67
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
!1 = !DIFile(filename: "if6/main.c", directory: "/home/rasika/llvm2goto/llvm2goto-regression-master")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{!"clang version 5.0.0 (trunk 295264)"}
!6 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 1, type: !7, isLocal: false, isDefinition: true, scopeLine: 2, isOptimized: false, unit: !0, variables: !2)
!7 = !DISubroutineType(types: !8)
!8 = !{!9}
!9 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!10 = !DILocalVariable(name: "x", scope: !6, file: !1, line: 3, type: !9)
!11 = !DIExpression()
!12 = !DILocation(line: 3, column: 6, scope: !6)
!13 = !DILocalVariable(name: "x_prev", scope: !6, file: !1, line: 4, type: !9)
!14 = !DILocation(line: 4, column: 6, scope: !6)
!15 = !DILocation(line: 4, column: 15, scope: !6)
!16 = !DILocation(line: 6, column: 5, scope: !17)
!17 = distinct !DILexicalBlock(scope: !6, file: !1, line: 6, column: 5)
!18 = !DILocation(line: 6, column: 6, scope: !17)
!19 = !DILocation(line: 6, column: 10, scope: !17)
!20 = !DILocation(line: 6, column: 13, scope: !21)
!21 = !DILexicalBlockFile(scope: !17, file: !1, discriminator: 2)
!22 = !DILocation(line: 6, column: 19, scope: !21)
!23 = !DILocation(line: 6, column: 5, scope: !24)
!24 = !DILexicalBlockFile(scope: !6, file: !1, discriminator: 2)
!25 = !DILocation(line: 8, column: 4, scope: !26)
!26 = distinct !DILexicalBlock(scope: !17, file: !1, line: 7, column: 2)
!27 = !DILocation(line: 9, column: 6, scope: !28)
!28 = distinct !DILexicalBlock(scope: !26, file: !1, line: 9, column: 6)
!29 = !DILocation(line: 9, column: 7, scope: !28)
!30 = !DILocation(line: 9, column: 6, scope: !26)
!31 = !DILocation(line: 11, column: 5, scope: !32)
!32 = distinct !DILexicalBlock(scope: !28, file: !1, line: 10, column: 3)
!33 = !DILocation(line: 12, column: 7, scope: !34)
!34 = distinct !DILexicalBlock(scope: !32, file: !1, line: 12, column: 7)
!35 = !DILocation(line: 12, column: 8, scope: !34)
!36 = !DILocation(line: 12, column: 7, scope: !32)
!37 = !DILocation(line: 14, column: 6, scope: !38)
!38 = distinct !DILexicalBlock(scope: !34, file: !1, line: 13, column: 4)
!39 = !DILocation(line: 16, column: 8, scope: !40)
!40 = distinct !DILexicalBlock(scope: !38, file: !1, line: 16, column: 8)
!41 = !DILocation(line: 16, column: 9, scope: !40)
!42 = !DILocation(line: 16, column: 8, scope: !38)
!43 = !DILocation(line: 17, column: 7, scope: !40)
!44 = !DILocation(line: 17, column: 6, scope: !40)
!45 = !DILocation(line: 18, column: 4, scope: !38)
!46 = !DILocation(line: 19, column: 3, scope: !32)
!47 = !DILocation(line: 20, column: 2, scope: !26)
!48 = !DILocation(line: 22, column: 12, scope: !6)
!49 = !DILocation(line: 22, column: 18, scope: !6)
!50 = !DILocation(line: 22, column: 22, scope: !6)
!51 = !DILocation(line: 22, column: 25, scope: !24)
!52 = !DILocation(line: 22, column: 26, scope: !24)
!53 = !DILocation(line: 22, column: 30, scope: !24)
!54 = !DILocation(line: 22, column: 34, scope: !55)
!55 = !DILexicalBlockFile(scope: !6, file: !1, discriminator: 4)
!56 = !DILocation(line: 22, column: 40, scope: !55)
!57 = !DILocation(line: 22, column: 43, scope: !55)
!58 = !DILocation(line: 22, column: 46, scope: !59)
!59 = !DILexicalBlockFile(scope: !6, file: !1, discriminator: 6)
!60 = !DILocation(line: 22, column: 54, scope: !59)
!61 = !DILocation(line: 22, column: 52, scope: !59)
!62 = !DILocation(line: 22, column: 30, scope: !63)
!63 = !DILexicalBlockFile(scope: !6, file: !1, discriminator: 8)
!64 = !DILocation(line: 22, column: 30, scope: !65)
!65 = !DILexicalBlockFile(scope: !6, file: !1, discriminator: 10)
!66 = !DILocation(line: 22, column: 4, scope: !65)
!67 = !DILocation(line: 24, column: 4, scope: !6)
