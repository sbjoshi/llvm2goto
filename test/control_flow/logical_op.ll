; ModuleID = 'control_flow/logical_op.c'
source_filename = "control_flow/logical_op.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define i32 @main() #0 !dbg !6 {
entry:
  %retval = alloca i32, align 4
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %k = alloca i32, align 4
  %l = alloca i32, align 4
  %m = alloca i32, align 4
  %n = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %i, metadata !10, metadata !11), !dbg !12
  call void @llvm.dbg.declare(metadata i32* %j, metadata !13, metadata !11), !dbg !14
  call void @llvm.dbg.declare(metadata i32* %k, metadata !15, metadata !11), !dbg !16
  call void @llvm.dbg.declare(metadata i32* %l, metadata !17, metadata !11), !dbg !18
  call void @llvm.dbg.declare(metadata i32* %m, metadata !19, metadata !11), !dbg !20
  call void @llvm.dbg.declare(metadata i32* %n, metadata !21, metadata !11), !dbg !22
  store i32 0, i32* %i, align 4, !dbg !23
  store i32 13, i32* %j, align 4, !dbg !24
  store i32 3, i32* %n, align 4, !dbg !25
  store i32 3, i32* %m, align 4, !dbg !26
  store i32 3, i32* %l, align 4, !dbg !27
  store i32 3, i32* %k, align 4, !dbg !28
  %0 = load i32, i32* %i, align 4, !dbg !29
  %1 = load i32, i32* %j, align 4, !dbg !31
  %cmp = icmp slt i32 %0, %1, !dbg !32
  br i1 %cmp, label %if.then, label %lor.lhs.false, !dbg !33

lor.lhs.false:                                    ; preds = %entry
  %2 = load i32, i32* %i, align 4, !dbg !34
  %3 = load i32, i32* %j, align 4, !dbg !36
  %cmp1 = icmp sgt i32 %2, %3, !dbg !37
  br i1 %cmp1, label %if.then, label %if.end, !dbg !38

if.then:                                          ; preds = %lor.lhs.false, %entry
  store i32 0, i32* %k, align 4, !dbg !40
  br label %if.end, !dbg !42

if.end:                                           ; preds = %if.then, %lor.lhs.false
  %4 = load i32, i32* %i, align 4, !dbg !43
  %5 = load i32, i32* %j, align 4, !dbg !45
  %cmp2 = icmp slt i32 %4, %5, !dbg !46
  br i1 %cmp2, label %land.lhs.true, label %if.end4, !dbg !47

land.lhs.true:                                    ; preds = %if.end
  %6 = load i32, i32* %j, align 4, !dbg !48
  %tobool = icmp ne i32 %6, 0, !dbg !48
  br i1 %tobool, label %if.then3, label %if.end4, !dbg !50

if.then3:                                         ; preds = %land.lhs.true
  store i32 1, i32* %l, align 4, !dbg !51
  br label %if.end4, !dbg !53

if.end4:                                          ; preds = %if.then3, %land.lhs.true, %if.end
  %7 = load i32, i32* %i, align 4, !dbg !54
  %tobool5 = icmp ne i32 %7, 0, !dbg !54
  br i1 %tobool5, label %if.then6, label %if.end7, !dbg !56

if.then6:                                         ; preds = %if.end4
  store i32 2, i32* %m, align 4, !dbg !57
  br label %if.end7, !dbg !59

if.end7:                                          ; preds = %if.then6, %if.end4
  %8 = load i32, i32* %i, align 4, !dbg !60
  %tobool8 = icmp ne i32 %8, 0, !dbg !60
  br i1 %tobool8, label %if.end10, label %if.then9, !dbg !62

if.then9:                                         ; preds = %if.end7
  store i32 3, i32* %n, align 4, !dbg !63
  br label %if.end10, !dbg !65

if.end10:                                         ; preds = %if.then9, %if.end7
  %9 = load i32, i32* %retval, align 4, !dbg !66
  ret i32 %9, !dbg !66
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4}
!llvm.ident = !{!5}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.0 (trunk 295264)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "control_flow/logical_op.c", directory: "/home/rasika/Downloads/llvm_clang/build/bin")
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
!17 = !DILocalVariable(name: "l", scope: !6, file: !1, line: 2, type: !9)
!18 = !DILocation(line: 2, column: 15, scope: !6)
!19 = !DILocalVariable(name: "m", scope: !6, file: !1, line: 2, type: !9)
!20 = !DILocation(line: 2, column: 18, scope: !6)
!21 = !DILocalVariable(name: "n", scope: !6, file: !1, line: 2, type: !9)
!22 = !DILocation(line: 2, column: 21, scope: !6)
!23 = !DILocation(line: 3, column: 4, scope: !6)
!24 = !DILocation(line: 4, column: 4, scope: !6)
!25 = !DILocation(line: 5, column: 16, scope: !6)
!26 = !DILocation(line: 5, column: 12, scope: !6)
!27 = !DILocation(line: 5, column: 8, scope: !6)
!28 = !DILocation(line: 5, column: 4, scope: !6)
!29 = !DILocation(line: 6, column: 6, scope: !30)
!30 = distinct !DILexicalBlock(scope: !6, file: !1, line: 6, column: 6)
!31 = !DILocation(line: 6, column: 8, scope: !30)
!32 = !DILocation(line: 6, column: 7, scope: !30)
!33 = !DILocation(line: 6, column: 10, scope: !30)
!34 = !DILocation(line: 6, column: 13, scope: !35)
!35 = !DILexicalBlockFile(scope: !30, file: !1, discriminator: 2)
!36 = !DILocation(line: 6, column: 15, scope: !35)
!37 = !DILocation(line: 6, column: 14, scope: !35)
!38 = !DILocation(line: 6, column: 6, scope: !39)
!39 = !DILexicalBlockFile(scope: !6, file: !1, discriminator: 2)
!40 = !DILocation(line: 7, column: 5, scope: !41)
!41 = distinct !DILexicalBlock(scope: !30, file: !1, line: 6, column: 18)
!42 = !DILocation(line: 8, column: 2, scope: !41)
!43 = !DILocation(line: 9, column: 6, scope: !44)
!44 = distinct !DILexicalBlock(scope: !6, file: !1, line: 9, column: 6)
!45 = !DILocation(line: 9, column: 8, scope: !44)
!46 = !DILocation(line: 9, column: 7, scope: !44)
!47 = !DILocation(line: 9, column: 10, scope: !44)
!48 = !DILocation(line: 9, column: 13, scope: !49)
!49 = !DILexicalBlockFile(scope: !44, file: !1, discriminator: 2)
!50 = !DILocation(line: 9, column: 6, scope: !39)
!51 = !DILocation(line: 10, column: 19, scope: !52)
!52 = distinct !DILexicalBlock(scope: !44, file: !1, line: 9, column: 16)
!53 = !DILocation(line: 11, column: 9, scope: !52)
!54 = !DILocation(line: 12, column: 6, scope: !55)
!55 = distinct !DILexicalBlock(scope: !6, file: !1, line: 12, column: 6)
!56 = !DILocation(line: 12, column: 6, scope: !6)
!57 = !DILocation(line: 13, column: 5, scope: !58)
!58 = distinct !DILexicalBlock(scope: !55, file: !1, line: 12, column: 9)
!59 = !DILocation(line: 14, column: 2, scope: !58)
!60 = !DILocation(line: 15, column: 7, scope: !61)
!61 = distinct !DILexicalBlock(scope: !6, file: !1, line: 15, column: 6)
!62 = !DILocation(line: 15, column: 6, scope: !6)
!63 = !DILocation(line: 16, column: 5, scope: !64)
!64 = distinct !DILexicalBlock(scope: !61, file: !1, line: 15, column: 10)
!65 = !DILocation(line: 17, column: 2, scope: !64)
!66 = !DILocation(line: 18, column: 1, scope: !6)
