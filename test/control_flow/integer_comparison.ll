; ModuleID = 'control_flow/integer_comparison.c'
source_filename = "control_flow/integer_comparison.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define i32 @main() #0 !dbg !6 {
entry:
  %retval = alloca i32, align 4
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %k = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %i, metadata !10, metadata !11), !dbg !12
  call void @llvm.dbg.declare(metadata i32* %j, metadata !13, metadata !11), !dbg !14
  call void @llvm.dbg.declare(metadata i32* %k, metadata !15, metadata !11), !dbg !16
  %0 = load i32, i32* %i, align 4, !dbg !17
  %1 = load i32, i32* %j, align 4, !dbg !19
  %cmp = icmp eq i32 %0, %1, !dbg !20
  br i1 %cmp, label %if.then, label %if.end, !dbg !21

if.then:                                          ; preds = %entry
  store i32 0, i32* %k, align 4, !dbg !22
  br label %if.end, !dbg !24

if.end:                                           ; preds = %if.then, %entry
  %2 = load i32, i32* %i, align 4, !dbg !25
  %3 = load i32, i32* %j, align 4, !dbg !27
  %cmp1 = icmp ne i32 %2, %3, !dbg !28
  br i1 %cmp1, label %if.then2, label %if.end3, !dbg !29

if.then2:                                         ; preds = %if.end
  store i32 1, i32* %k, align 4, !dbg !30
  br label %if.end3, !dbg !32

if.end3:                                          ; preds = %if.then2, %if.end
  %4 = load i32, i32* %i, align 4, !dbg !33
  %5 = load i32, i32* %j, align 4, !dbg !35
  %cmp4 = icmp slt i32 %4, %5, !dbg !36
  br i1 %cmp4, label %if.then5, label %if.end6, !dbg !37

if.then5:                                         ; preds = %if.end3
  store i32 2, i32* %k, align 4, !dbg !38
  br label %if.end6, !dbg !40

if.end6:                                          ; preds = %if.then5, %if.end3
  %6 = load i32, i32* %i, align 4, !dbg !41
  %7 = load i32, i32* %j, align 4, !dbg !43
  %cmp7 = icmp sle i32 %6, %7, !dbg !44
  br i1 %cmp7, label %if.then8, label %if.end9, !dbg !45

if.then8:                                         ; preds = %if.end6
  store i32 3, i32* %k, align 4, !dbg !46
  br label %if.end9, !dbg !48

if.end9:                                          ; preds = %if.then8, %if.end6
  %8 = load i32, i32* %i, align 4, !dbg !49
  %9 = load i32, i32* %j, align 4, !dbg !51
  %cmp10 = icmp sgt i32 %8, %9, !dbg !52
  br i1 %cmp10, label %if.then11, label %if.end12, !dbg !53

if.then11:                                        ; preds = %if.end9
  store i32 4, i32* %k, align 4, !dbg !54
  br label %if.end12, !dbg !56

if.end12:                                         ; preds = %if.then11, %if.end9
  %10 = load i32, i32* %i, align 4, !dbg !57
  %11 = load i32, i32* %j, align 4, !dbg !59
  %cmp13 = icmp sge i32 %10, %11, !dbg !60
  br i1 %cmp13, label %if.then14, label %if.end15, !dbg !61

if.then14:                                        ; preds = %if.end12
  store i32 5, i32* %k, align 4, !dbg !62
  br label %if.end15, !dbg !64

if.end15:                                         ; preds = %if.then14, %if.end12
  %12 = load i32, i32* %j, align 4, !dbg !65
  %cmp16 = icmp eq i32 0, %12, !dbg !67
  br i1 %cmp16, label %if.then17, label %if.end18, !dbg !68

if.then17:                                        ; preds = %if.end15
  store i32 6, i32* %k, align 4, !dbg !69
  br label %if.end18, !dbg !71

if.end18:                                         ; preds = %if.then17, %if.end15
  %13 = load i32, i32* %j, align 4, !dbg !72
  %cmp19 = icmp ne i32 0, %13, !dbg !74
  br i1 %cmp19, label %if.then20, label %if.end21, !dbg !75

if.then20:                                        ; preds = %if.end18
  store i32 7, i32* %k, align 4, !dbg !76
  br label %if.end21, !dbg !78

if.end21:                                         ; preds = %if.then20, %if.end18
  %14 = load i32, i32* %j, align 4, !dbg !79
  %cmp22 = icmp slt i32 0, %14, !dbg !81
  br i1 %cmp22, label %if.then23, label %if.end24, !dbg !82

if.then23:                                        ; preds = %if.end21
  store i32 8, i32* %k, align 4, !dbg !83
  br label %if.end24, !dbg !85

if.end24:                                         ; preds = %if.then23, %if.end21
  %15 = load i32, i32* %j, align 4, !dbg !86
  %cmp25 = icmp sle i32 0, %15, !dbg !88
  br i1 %cmp25, label %if.then26, label %if.end27, !dbg !89

if.then26:                                        ; preds = %if.end24
  store i32 9, i32* %k, align 4, !dbg !90
  br label %if.end27, !dbg !92

if.end27:                                         ; preds = %if.then26, %if.end24
  %16 = load i32, i32* %j, align 4, !dbg !93
  %cmp28 = icmp sgt i32 0, %16, !dbg !95
  br i1 %cmp28, label %if.then29, label %if.end30, !dbg !96

if.then29:                                        ; preds = %if.end27
  store i32 10, i32* %k, align 4, !dbg !97
  br label %if.end30, !dbg !99

if.end30:                                         ; preds = %if.then29, %if.end27
  %17 = load i32, i32* %j, align 4, !dbg !100
  %cmp31 = icmp sge i32 0, %17, !dbg !102
  br i1 %cmp31, label %if.then32, label %if.end33, !dbg !103

if.then32:                                        ; preds = %if.end30
  store i32 11, i32* %k, align 4, !dbg !104
  br label %if.end33, !dbg !106

if.end33:                                         ; preds = %if.then32, %if.end30
  %18 = load i32, i32* %i, align 4, !dbg !107
  %cmp34 = icmp eq i32 %18, 0, !dbg !109
  br i1 %cmp34, label %if.then35, label %if.end36, !dbg !110

if.then35:                                        ; preds = %if.end33
  store i32 12, i32* %k, align 4, !dbg !111
  br label %if.end36, !dbg !113

if.end36:                                         ; preds = %if.then35, %if.end33
  %19 = load i32, i32* %i, align 4, !dbg !114
  %cmp37 = icmp ne i32 %19, 0, !dbg !116
  br i1 %cmp37, label %if.then38, label %if.end39, !dbg !117

if.then38:                                        ; preds = %if.end36
  store i32 13, i32* %k, align 4, !dbg !118
  br label %if.end39, !dbg !120

if.end39:                                         ; preds = %if.then38, %if.end36
  %20 = load i32, i32* %i, align 4, !dbg !121
  %cmp40 = icmp slt i32 %20, 0, !dbg !123
  br i1 %cmp40, label %if.then41, label %if.end42, !dbg !124

if.then41:                                        ; preds = %if.end39
  store i32 14, i32* %k, align 4, !dbg !125
  br label %if.end42, !dbg !127

if.end42:                                         ; preds = %if.then41, %if.end39
  %21 = load i32, i32* %i, align 4, !dbg !128
  %cmp43 = icmp sle i32 %21, 0, !dbg !130
  br i1 %cmp43, label %if.then44, label %if.end45, !dbg !131

if.then44:                                        ; preds = %if.end42
  store i32 15, i32* %k, align 4, !dbg !132
  br label %if.end45, !dbg !134

if.end45:                                         ; preds = %if.then44, %if.end42
  %22 = load i32, i32* %i, align 4, !dbg !135
  %cmp46 = icmp sgt i32 %22, 0, !dbg !137
  br i1 %cmp46, label %if.then47, label %if.end48, !dbg !138

if.then47:                                        ; preds = %if.end45
  store i32 16, i32* %k, align 4, !dbg !139
  br label %if.end48, !dbg !141

if.end48:                                         ; preds = %if.then47, %if.end45
  %23 = load i32, i32* %i, align 4, !dbg !142
  %cmp49 = icmp sge i32 %23, 0, !dbg !144
  br i1 %cmp49, label %if.then50, label %if.end51, !dbg !145

if.then50:                                        ; preds = %if.end48
  store i32 17, i32* %k, align 4, !dbg !146
  br label %if.end51, !dbg !148

if.end51:                                         ; preds = %if.then50, %if.end48
  store i32 18, i32* %k, align 4, !dbg !149
  store i32 0, i32* %i, align 4, !dbg !152
  store i32 0, i32* %j, align 4, !dbg !153
  ret i32 0, !dbg !154
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4}
!llvm.ident = !{!5}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.0 (trunk 295264)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "control_flow/integer_comparison.c", directory: "/home/rasika/Downloads/llvm_clang/build/bin")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{!"clang version 5.0.0 (trunk 295264)"}
!6 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 1, type: !7, isLocal: false, isDefinition: true, scopeLine: 1, isOptimized: false, unit: !0, variables: !2)
!7 = !DISubroutineType(types: !8)
!8 = !{!9}
!9 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!10 = !DILocalVariable(name: "i", scope: !6, file: !1, line: 2, type: !9)
!11 = !DIExpression()
!12 = !DILocation(line: 2, column: 6, scope: !6)
!13 = !DILocalVariable(name: "j", scope: !6, file: !1, line: 2, type: !9)
!14 = !DILocation(line: 2, column: 9, scope: !6)
!15 = !DILocalVariable(name: "k", scope: !6, file: !1, line: 2, type: !9)
!16 = !DILocation(line: 2, column: 12, scope: !6)
!17 = !DILocation(line: 3, column: 5, scope: !18)
!18 = distinct !DILexicalBlock(scope: !6, file: !1, line: 3, column: 5)
!19 = !DILocation(line: 3, column: 10, scope: !18)
!20 = !DILocation(line: 3, column: 7, scope: !18)
!21 = !DILocation(line: 3, column: 5, scope: !6)
!22 = !DILocation(line: 4, column: 5, scope: !23)
!23 = distinct !DILexicalBlock(scope: !18, file: !1, line: 3, column: 13)
!24 = !DILocation(line: 5, column: 2, scope: !23)
!25 = !DILocation(line: 6, column: 5, scope: !26)
!26 = distinct !DILexicalBlock(scope: !6, file: !1, line: 6, column: 5)
!27 = !DILocation(line: 6, column: 10, scope: !26)
!28 = !DILocation(line: 6, column: 7, scope: !26)
!29 = !DILocation(line: 6, column: 5, scope: !6)
!30 = !DILocation(line: 7, column: 5, scope: !31)
!31 = distinct !DILexicalBlock(scope: !26, file: !1, line: 6, column: 13)
!32 = !DILocation(line: 8, column: 2, scope: !31)
!33 = !DILocation(line: 9, column: 5, scope: !34)
!34 = distinct !DILexicalBlock(scope: !6, file: !1, line: 9, column: 5)
!35 = !DILocation(line: 9, column: 9, scope: !34)
!36 = !DILocation(line: 9, column: 7, scope: !34)
!37 = !DILocation(line: 9, column: 5, scope: !6)
!38 = !DILocation(line: 10, column: 5, scope: !39)
!39 = distinct !DILexicalBlock(scope: !34, file: !1, line: 9, column: 12)
!40 = !DILocation(line: 11, column: 2, scope: !39)
!41 = !DILocation(line: 12, column: 5, scope: !42)
!42 = distinct !DILexicalBlock(scope: !6, file: !1, line: 12, column: 5)
!43 = !DILocation(line: 12, column: 10, scope: !42)
!44 = !DILocation(line: 12, column: 7, scope: !42)
!45 = !DILocation(line: 12, column: 5, scope: !6)
!46 = !DILocation(line: 13, column: 5, scope: !47)
!47 = distinct !DILexicalBlock(scope: !42, file: !1, line: 12, column: 13)
!48 = !DILocation(line: 14, column: 2, scope: !47)
!49 = !DILocation(line: 15, column: 5, scope: !50)
!50 = distinct !DILexicalBlock(scope: !6, file: !1, line: 15, column: 5)
!51 = !DILocation(line: 15, column: 9, scope: !50)
!52 = !DILocation(line: 15, column: 7, scope: !50)
!53 = !DILocation(line: 15, column: 5, scope: !6)
!54 = !DILocation(line: 16, column: 5, scope: !55)
!55 = distinct !DILexicalBlock(scope: !50, file: !1, line: 15, column: 12)
!56 = !DILocation(line: 17, column: 2, scope: !55)
!57 = !DILocation(line: 18, column: 5, scope: !58)
!58 = distinct !DILexicalBlock(scope: !6, file: !1, line: 18, column: 5)
!59 = !DILocation(line: 18, column: 10, scope: !58)
!60 = !DILocation(line: 18, column: 7, scope: !58)
!61 = !DILocation(line: 18, column: 5, scope: !6)
!62 = !DILocation(line: 19, column: 5, scope: !63)
!63 = distinct !DILexicalBlock(scope: !58, file: !1, line: 18, column: 13)
!64 = !DILocation(line: 20, column: 2, scope: !63)
!65 = !DILocation(line: 21, column: 10, scope: !66)
!66 = distinct !DILexicalBlock(scope: !6, file: !1, line: 21, column: 5)
!67 = !DILocation(line: 21, column: 7, scope: !66)
!68 = !DILocation(line: 21, column: 5, scope: !6)
!69 = !DILocation(line: 22, column: 5, scope: !70)
!70 = distinct !DILexicalBlock(scope: !66, file: !1, line: 21, column: 13)
!71 = !DILocation(line: 23, column: 2, scope: !70)
!72 = !DILocation(line: 24, column: 10, scope: !73)
!73 = distinct !DILexicalBlock(scope: !6, file: !1, line: 24, column: 5)
!74 = !DILocation(line: 24, column: 7, scope: !73)
!75 = !DILocation(line: 24, column: 5, scope: !6)
!76 = !DILocation(line: 25, column: 5, scope: !77)
!77 = distinct !DILexicalBlock(scope: !73, file: !1, line: 24, column: 13)
!78 = !DILocation(line: 26, column: 2, scope: !77)
!79 = !DILocation(line: 27, column: 9, scope: !80)
!80 = distinct !DILexicalBlock(scope: !6, file: !1, line: 27, column: 5)
!81 = !DILocation(line: 27, column: 7, scope: !80)
!82 = !DILocation(line: 27, column: 5, scope: !6)
!83 = !DILocation(line: 28, column: 5, scope: !84)
!84 = distinct !DILexicalBlock(scope: !80, file: !1, line: 27, column: 12)
!85 = !DILocation(line: 29, column: 2, scope: !84)
!86 = !DILocation(line: 30, column: 10, scope: !87)
!87 = distinct !DILexicalBlock(scope: !6, file: !1, line: 30, column: 5)
!88 = !DILocation(line: 30, column: 7, scope: !87)
!89 = !DILocation(line: 30, column: 5, scope: !6)
!90 = !DILocation(line: 31, column: 5, scope: !91)
!91 = distinct !DILexicalBlock(scope: !87, file: !1, line: 30, column: 13)
!92 = !DILocation(line: 32, column: 2, scope: !91)
!93 = !DILocation(line: 33, column: 9, scope: !94)
!94 = distinct !DILexicalBlock(scope: !6, file: !1, line: 33, column: 5)
!95 = !DILocation(line: 33, column: 7, scope: !94)
!96 = !DILocation(line: 33, column: 5, scope: !6)
!97 = !DILocation(line: 34, column: 5, scope: !98)
!98 = distinct !DILexicalBlock(scope: !94, file: !1, line: 33, column: 12)
!99 = !DILocation(line: 35, column: 2, scope: !98)
!100 = !DILocation(line: 36, column: 10, scope: !101)
!101 = distinct !DILexicalBlock(scope: !6, file: !1, line: 36, column: 5)
!102 = !DILocation(line: 36, column: 7, scope: !101)
!103 = !DILocation(line: 36, column: 5, scope: !6)
!104 = !DILocation(line: 37, column: 5, scope: !105)
!105 = distinct !DILexicalBlock(scope: !101, file: !1, line: 36, column: 13)
!106 = !DILocation(line: 38, column: 2, scope: !105)
!107 = !DILocation(line: 39, column: 5, scope: !108)
!108 = distinct !DILexicalBlock(scope: !6, file: !1, line: 39, column: 5)
!109 = !DILocation(line: 39, column: 7, scope: !108)
!110 = !DILocation(line: 39, column: 5, scope: !6)
!111 = !DILocation(line: 40, column: 5, scope: !112)
!112 = distinct !DILexicalBlock(scope: !108, file: !1, line: 39, column: 13)
!113 = !DILocation(line: 41, column: 2, scope: !112)
!114 = !DILocation(line: 42, column: 5, scope: !115)
!115 = distinct !DILexicalBlock(scope: !6, file: !1, line: 42, column: 5)
!116 = !DILocation(line: 42, column: 7, scope: !115)
!117 = !DILocation(line: 42, column: 5, scope: !6)
!118 = !DILocation(line: 43, column: 5, scope: !119)
!119 = distinct !DILexicalBlock(scope: !115, file: !1, line: 42, column: 13)
!120 = !DILocation(line: 44, column: 2, scope: !119)
!121 = !DILocation(line: 45, column: 5, scope: !122)
!122 = distinct !DILexicalBlock(scope: !6, file: !1, line: 45, column: 5)
!123 = !DILocation(line: 45, column: 7, scope: !122)
!124 = !DILocation(line: 45, column: 5, scope: !6)
!125 = !DILocation(line: 46, column: 5, scope: !126)
!126 = distinct !DILexicalBlock(scope: !122, file: !1, line: 45, column: 12)
!127 = !DILocation(line: 47, column: 2, scope: !126)
!128 = !DILocation(line: 48, column: 5, scope: !129)
!129 = distinct !DILexicalBlock(scope: !6, file: !1, line: 48, column: 5)
!130 = !DILocation(line: 48, column: 7, scope: !129)
!131 = !DILocation(line: 48, column: 5, scope: !6)
!132 = !DILocation(line: 49, column: 5, scope: !133)
!133 = distinct !DILexicalBlock(scope: !129, file: !1, line: 48, column: 13)
!134 = !DILocation(line: 50, column: 2, scope: !133)
!135 = !DILocation(line: 51, column: 5, scope: !136)
!136 = distinct !DILexicalBlock(scope: !6, file: !1, line: 51, column: 5)
!137 = !DILocation(line: 51, column: 7, scope: !136)
!138 = !DILocation(line: 51, column: 5, scope: !6)
!139 = !DILocation(line: 52, column: 5, scope: !140)
!140 = distinct !DILexicalBlock(scope: !136, file: !1, line: 51, column: 12)
!141 = !DILocation(line: 53, column: 2, scope: !140)
!142 = !DILocation(line: 54, column: 5, scope: !143)
!143 = distinct !DILexicalBlock(scope: !6, file: !1, line: 54, column: 5)
!144 = !DILocation(line: 54, column: 7, scope: !143)
!145 = !DILocation(line: 54, column: 5, scope: !6)
!146 = !DILocation(line: 55, column: 5, scope: !147)
!147 = distinct !DILexicalBlock(scope: !143, file: !1, line: 54, column: 13)
!148 = !DILocation(line: 56, column: 2, scope: !147)
!149 = !DILocation(line: 58, column: 5, scope: !150)
!150 = distinct !DILexicalBlock(scope: !151, file: !1, line: 57, column: 8)
!151 = distinct !DILexicalBlock(scope: !6, file: !1, line: 57, column: 5)
!152 = !DILocation(line: 63, column: 4, scope: !6)
!153 = !DILocation(line: 64, column: 4, scope: !6)
!154 = !DILocation(line: 65, column: 2, scope: !6)
