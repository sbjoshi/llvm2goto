; ModuleID = 'if4/main.c'
source_filename = "if4/main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !7 {
entry:
  %retval = alloca i32, align 4
  %num1 = alloca i32, align 4
  %num2 = alloca i32, align 4
  %num3 = alloca i32, align 4
  %max = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %num1, metadata !11, metadata !DIExpression()), !dbg !12
  call void @llvm.dbg.declare(metadata i32* %num2, metadata !13, metadata !DIExpression()), !dbg !14
  call void @llvm.dbg.declare(metadata i32* %num3, metadata !15, metadata !DIExpression()), !dbg !16
  call void @llvm.dbg.declare(metadata i32* %max, metadata !17, metadata !DIExpression()), !dbg !18
  %0 = load i32, i32* %num1, align 4, !dbg !19
  %1 = load i32, i32* %num2, align 4, !dbg !21
  %cmp = icmp sgt i32 %0, %1, !dbg !22
  br i1 %cmp, label %if.then, label %if.else3, !dbg !23

if.then:                                          ; preds = %entry
  %2 = load i32, i32* %num1, align 4, !dbg !24
  %3 = load i32, i32* %num3, align 4, !dbg !27
  %cmp1 = icmp sgt i32 %2, %3, !dbg !28
  br i1 %cmp1, label %if.then2, label %if.else, !dbg !29

if.then2:                                         ; preds = %if.then
  %4 = load i32, i32* %num1, align 4, !dbg !30
  store i32 %4, i32* %max, align 4, !dbg !32
  br label %if.end, !dbg !33

if.else:                                          ; preds = %if.then
  %5 = load i32, i32* %num3, align 4, !dbg !34
  store i32 %5, i32* %max, align 4, !dbg !36
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then2
  br label %if.end8, !dbg !37

if.else3:                                         ; preds = %entry
  %6 = load i32, i32* %num2, align 4, !dbg !38
  %7 = load i32, i32* %num3, align 4, !dbg !41
  %cmp4 = icmp sgt i32 %6, %7, !dbg !42
  br i1 %cmp4, label %if.then5, label %if.else6, !dbg !43

if.then5:                                         ; preds = %if.else3
  %8 = load i32, i32* %num2, align 4, !dbg !44
  store i32 %8, i32* %max, align 4, !dbg !46
  br label %if.end7, !dbg !47

if.else6:                                         ; preds = %if.else3
  %9 = load i32, i32* %num3, align 4, !dbg !48
  store i32 %9, i32* %max, align 4, !dbg !50
  br label %if.end7

if.end7:                                          ; preds = %if.else6, %if.then5
  br label %if.end8

if.end8:                                          ; preds = %if.end7, %if.end
  %10 = load i32, i32* %max, align 4, !dbg !51
  %11 = load i32, i32* %num1, align 4, !dbg !52
  %cmp9 = icmp sge i32 %10, %11, !dbg !53
  br i1 %cmp9, label %land.lhs.true, label %lor.lhs.false, !dbg !54

land.lhs.true:                                    ; preds = %if.end8
  %12 = load i32, i32* %max, align 4, !dbg !55
  %13 = load i32, i32* %num2, align 4, !dbg !56
  %cmp10 = icmp sge i32 %12, %13, !dbg !57
  br i1 %cmp10, label %lor.end, label %lor.lhs.false, !dbg !58

lor.lhs.false:                                    ; preds = %land.lhs.true, %if.end8
  %14 = load i32, i32* %max, align 4, !dbg !59
  %15 = load i32, i32* %num2, align 4, !dbg !60
  %cmp11 = icmp sge i32 %14, %15, !dbg !61
  br i1 %cmp11, label %land.lhs.true12, label %lor.rhs, !dbg !62

land.lhs.true12:                                  ; preds = %lor.lhs.false
  %16 = load i32, i32* %max, align 4, !dbg !63
  %17 = load i32, i32* %num3, align 4, !dbg !64
  %cmp13 = icmp sge i32 %16, %17, !dbg !65
  br i1 %cmp13, label %lor.end, label %lor.rhs, !dbg !66

lor.rhs:                                          ; preds = %land.lhs.true12, %lor.lhs.false
  %18 = load i32, i32* %max, align 4, !dbg !67
  %19 = load i32, i32* %num1, align 4, !dbg !68
  %cmp14 = icmp sge i32 %18, %19, !dbg !69
  br i1 %cmp14, label %land.rhs, label %land.end, !dbg !70

land.rhs:                                         ; preds = %lor.rhs
  %20 = load i32, i32* %max, align 4, !dbg !71
  %21 = load i32, i32* %num3, align 4, !dbg !72
  %cmp15 = icmp sge i32 %20, %21, !dbg !73
  br label %land.end

land.end:                                         ; preds = %land.rhs, %lor.rhs
  %22 = phi i1 [ false, %lor.rhs ], [ %cmp15, %land.rhs ], !dbg !74
  br label %lor.end, !dbg !66

lor.end:                                          ; preds = %land.end, %land.lhs.true12, %land.lhs.true
  %23 = phi i1 [ true, %land.lhs.true12 ], [ true, %land.lhs.true ], [ %22, %land.end ]
  %lor.ext = zext i1 %23 to i32, !dbg !66
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %lor.ext), !dbg !75
  %24 = load i32, i32* %max, align 4, !dbg !76
  %25 = load i32, i32* %num1, align 4, !dbg !77
  %cmp16 = icmp eq i32 %24, %25, !dbg !78
  br i1 %cmp16, label %lor.end21, label %lor.lhs.false17, !dbg !79

lor.lhs.false17:                                  ; preds = %lor.end
  %26 = load i32, i32* %max, align 4, !dbg !80
  %27 = load i32, i32* %num2, align 4, !dbg !81
  %cmp18 = icmp eq i32 %26, %27, !dbg !82
  br i1 %cmp18, label %lor.end21, label %lor.rhs19, !dbg !83

lor.rhs19:                                        ; preds = %lor.lhs.false17
  %28 = load i32, i32* %max, align 4, !dbg !84
  %29 = load i32, i32* %num3, align 4, !dbg !85
  %cmp20 = icmp eq i32 %28, %29, !dbg !86
  br label %lor.end21, !dbg !83

lor.end21:                                        ; preds = %lor.rhs19, %lor.lhs.false17, %lor.end
  %30 = phi i1 [ true, %lor.lhs.false17 ], [ true, %lor.end ], [ %cmp20, %lor.rhs19 ]
  %lor.ext22 = zext i1 %30 to i32, !dbg !83
  %call23 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %lor.ext22), !dbg !87
  ret i32 0, !dbg !88
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare dso_local i32 @assert(...) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 7.0.1 (https://github.com/llvm-mirror/clang.git 4519e2637fcc4bf6e3049a0a80e6a5e7b97667cb) (https://github.com/llvm-mirror/llvm.git cd98f42d0747826062fc3d2d2fad383aedf58dd6)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "if4/main.c", directory: "/home/akash/Documents/CBMC/cbmc/src/llvm2goto/regression")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 7.0.1 (https://github.com/llvm-mirror/clang.git 4519e2637fcc4bf6e3049a0a80e6a5e7b97667cb) (https://github.com/llvm-mirror/llvm.git cd98f42d0747826062fc3d2d2fad383aedf58dd6)"}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 1, type: !8, isLocal: false, isDefinition: true, scopeLine: 2, isOptimized: false, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "num1", scope: !7, file: !1, line: 3, type: !10)
!12 = !DILocation(line: 3, column: 6, scope: !7)
!13 = !DILocalVariable(name: "num2", scope: !7, file: !1, line: 3, type: !10)
!14 = !DILocation(line: 3, column: 12, scope: !7)
!15 = !DILocalVariable(name: "num3", scope: !7, file: !1, line: 3, type: !10)
!16 = !DILocation(line: 3, column: 17, scope: !7)
!17 = !DILocalVariable(name: "max", scope: !7, file: !1, line: 4, type: !10)
!18 = !DILocation(line: 4, column: 6, scope: !7)
!19 = !DILocation(line: 6, column: 8, scope: !20)
!20 = distinct !DILexicalBlock(scope: !7, file: !1, line: 6, column: 8)
!21 = !DILocation(line: 6, column: 15, scope: !20)
!22 = !DILocation(line: 6, column: 13, scope: !20)
!23 = !DILocation(line: 6, column: 8, scope: !7)
!24 = !DILocation(line: 8, column: 12, scope: !25)
!25 = distinct !DILexicalBlock(scope: !26, file: !1, line: 8, column: 12)
!26 = distinct !DILexicalBlock(scope: !20, file: !1, line: 7, column: 5)
!27 = !DILocation(line: 8, column: 19, scope: !25)
!28 = !DILocation(line: 8, column: 17, scope: !25)
!29 = !DILocation(line: 8, column: 12, scope: !26)
!30 = !DILocation(line: 11, column: 19, scope: !31)
!31 = distinct !DILexicalBlock(scope: !25, file: !1, line: 9, column: 9)
!32 = !DILocation(line: 11, column: 17, scope: !31)
!33 = !DILocation(line: 12, column: 9, scope: !31)
!34 = !DILocation(line: 16, column: 19, scope: !35)
!35 = distinct !DILexicalBlock(scope: !25, file: !1, line: 14, column: 9)
!36 = !DILocation(line: 16, column: 17, scope: !35)
!37 = !DILocation(line: 18, column: 5, scope: !26)
!38 = !DILocation(line: 21, column: 12, scope: !39)
!39 = distinct !DILexicalBlock(scope: !40, file: !1, line: 21, column: 12)
!40 = distinct !DILexicalBlock(scope: !20, file: !1, line: 20, column: 5)
!41 = !DILocation(line: 21, column: 19, scope: !39)
!42 = !DILocation(line: 21, column: 17, scope: !39)
!43 = !DILocation(line: 21, column: 12, scope: !40)
!44 = !DILocation(line: 24, column: 19, scope: !45)
!45 = distinct !DILexicalBlock(scope: !39, file: !1, line: 22, column: 9)
!46 = !DILocation(line: 24, column: 17, scope: !45)
!47 = !DILocation(line: 25, column: 9, scope: !45)
!48 = !DILocation(line: 29, column: 19, scope: !49)
!49 = distinct !DILexicalBlock(scope: !39, file: !1, line: 27, column: 9)
!50 = !DILocation(line: 29, column: 17, scope: !49)
!51 = !DILocation(line: 33, column: 12, scope: !7)
!52 = !DILocation(line: 33, column: 17, scope: !7)
!53 = !DILocation(line: 33, column: 15, scope: !7)
!54 = !DILocation(line: 33, column: 22, scope: !7)
!55 = !DILocation(line: 33, column: 25, scope: !7)
!56 = !DILocation(line: 33, column: 30, scope: !7)
!57 = !DILocation(line: 33, column: 28, scope: !7)
!58 = !DILocation(line: 33, column: 36, scope: !7)
!59 = !DILocation(line: 33, column: 40, scope: !7)
!60 = !DILocation(line: 33, column: 45, scope: !7)
!61 = !DILocation(line: 33, column: 43, scope: !7)
!62 = !DILocation(line: 33, column: 50, scope: !7)
!63 = !DILocation(line: 33, column: 53, scope: !7)
!64 = !DILocation(line: 33, column: 58, scope: !7)
!65 = !DILocation(line: 33, column: 56, scope: !7)
!66 = !DILocation(line: 33, column: 64, scope: !7)
!67 = !DILocation(line: 33, column: 68, scope: !7)
!68 = !DILocation(line: 33, column: 73, scope: !7)
!69 = !DILocation(line: 33, column: 71, scope: !7)
!70 = !DILocation(line: 33, column: 78, scope: !7)
!71 = !DILocation(line: 33, column: 81, scope: !7)
!72 = !DILocation(line: 33, column: 86, scope: !7)
!73 = !DILocation(line: 33, column: 84, scope: !7)
!74 = !DILocation(line: 0, scope: !7)
!75 = !DILocation(line: 33, column: 4, scope: !7)
!76 = !DILocation(line: 34, column: 11, scope: !7)
!77 = !DILocation(line: 34, column: 18, scope: !7)
!78 = !DILocation(line: 34, column: 15, scope: !7)
!79 = !DILocation(line: 34, column: 23, scope: !7)
!80 = !DILocation(line: 34, column: 26, scope: !7)
!81 = !DILocation(line: 34, column: 33, scope: !7)
!82 = !DILocation(line: 34, column: 30, scope: !7)
!83 = !DILocation(line: 34, column: 38, scope: !7)
!84 = !DILocation(line: 34, column: 41, scope: !7)
!85 = !DILocation(line: 34, column: 46, scope: !7)
!86 = !DILocation(line: 34, column: 44, scope: !7)
!87 = !DILocation(line: 34, column: 4, scope: !7)
!88 = !DILocation(line: 36, column: 4, scope: !7)
