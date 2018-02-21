; ModuleID = '2002-05-03-NotTest.c'
source_filename = "2002-05-03-NotTest.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define void @testBitWiseNot(i32 %A, i32 %B, i32 %C, i32 %D) #0 !dbg !7 {
entry:
  %A.addr = alloca i32, align 4
  %B.addr = alloca i32, align 4
  %C.addr = alloca i32, align 4
  %D.addr = alloca i32, align 4
  store i32 %A, i32* %A.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %A.addr, metadata !11, metadata !12), !dbg !13
  store i32 %B, i32* %B.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %B.addr, metadata !14, metadata !12), !dbg !15
  store i32 %C, i32* %C.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %C.addr, metadata !16, metadata !12), !dbg !17
  store i32 %D, i32* %D.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %D.addr, metadata !18, metadata !12), !dbg !19
  %0 = load i32, i32* %A.addr, align 4, !dbg !20
  %neg = xor i32 %0, -1, !dbg !21
  %cmp = icmp eq i32 %neg, -2, !dbg !22
  %conv = zext i1 %cmp to i32, !dbg !22
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !23
  %1 = load i32, i32* %B.addr, align 4, !dbg !24
  %neg1 = xor i32 %1, -1, !dbg !25
  %cmp2 = icmp eq i32 %neg1, -3, !dbg !26
  %conv3 = zext i1 %cmp2 to i32, !dbg !26
  %call4 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv3), !dbg !27
  %2 = load i32, i32* %C.addr, align 4, !dbg !28
  %neg5 = xor i32 %2, -1, !dbg !29
  %cmp6 = icmp eq i32 %neg5, 2, !dbg !30
  %conv7 = zext i1 %cmp6 to i32, !dbg !30
  %call8 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv7), !dbg !31
  %3 = load i32, i32* %D.addr, align 4, !dbg !32
  %neg9 = xor i32 %3, -1, !dbg !33
  %cmp10 = icmp eq i32 %neg9, -6, !dbg !34
  %conv11 = zext i1 %cmp10 to i32, !dbg !34
  %call12 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv11), !dbg !35
  ret void, !dbg !36
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i32 @assert(...) #2

; Function Attrs: noinline nounwind optnone uwtable
define void @testBooleanNot(i32 %A, i32 %B, i32 %C, i32 %D) #0 !dbg !37 {
entry:
  %A.addr = alloca i32, align 4
  %B.addr = alloca i32, align 4
  %C.addr = alloca i32, align 4
  %D.addr = alloca i32, align 4
  store i32 %A, i32* %A.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %A.addr, metadata !38, metadata !12), !dbg !39
  store i32 %B, i32* %B.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %B.addr, metadata !40, metadata !12), !dbg !41
  store i32 %C, i32* %C.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %C.addr, metadata !42, metadata !12), !dbg !43
  store i32 %D, i32* %D.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %D.addr, metadata !44, metadata !12), !dbg !45
  %0 = load i32, i32* %A.addr, align 4, !dbg !46
  %cmp = icmp sgt i32 %0, 0, !dbg !47
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !48

land.rhs:                                         ; preds = %entry
  %1 = load i32, i32* %B.addr, align 4, !dbg !49
  %cmp1 = icmp sgt i32 %1, 0, !dbg !50
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %2 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ]
  %lnot = xor i1 %2, true, !dbg !51
  %lnot.ext = zext i1 %lnot to i32, !dbg !51
  %cmp2 = icmp eq i32 %lnot.ext, 0, !dbg !52
  %conv = zext i1 %cmp2 to i32, !dbg !52
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !53
  %3 = load i32, i32* %A.addr, align 4, !dbg !54
  %cmp3 = icmp sgt i32 %3, 0, !dbg !55
  br i1 %cmp3, label %land.rhs5, label %land.end8, !dbg !56

land.rhs5:                                        ; preds = %land.end
  %4 = load i32, i32* %C.addr, align 4, !dbg !57
  %cmp6 = icmp sgt i32 %4, 0, !dbg !58
  br label %land.end8

land.end8:                                        ; preds = %land.rhs5, %land.end
  %5 = phi i1 [ false, %land.end ], [ %cmp6, %land.rhs5 ]
  %lnot9 = xor i1 %5, true, !dbg !59
  %lnot.ext10 = zext i1 %lnot9 to i32, !dbg !59
  %cmp11 = icmp eq i32 %lnot.ext10, 1, !dbg !60
  %conv12 = zext i1 %cmp11 to i32, !dbg !60
  %call13 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv12), !dbg !61
  %6 = load i32, i32* %A.addr, align 4, !dbg !62
  %cmp14 = icmp sgt i32 %6, 0, !dbg !63
  br i1 %cmp14, label %land.rhs16, label %land.end19, !dbg !64

land.rhs16:                                       ; preds = %land.end8
  %7 = load i32, i32* %D.addr, align 4, !dbg !65
  %cmp17 = icmp sgt i32 %7, 0, !dbg !66
  br label %land.end19

land.end19:                                       ; preds = %land.rhs16, %land.end8
  %8 = phi i1 [ false, %land.end8 ], [ %cmp17, %land.rhs16 ]
  %lnot20 = xor i1 %8, true, !dbg !67
  %lnot.ext21 = zext i1 %lnot20 to i32, !dbg !67
  %cmp22 = icmp eq i32 %lnot.ext21, 0, !dbg !68
  %conv23 = zext i1 %cmp22 to i32, !dbg !68
  %call24 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv23), !dbg !69
  %9 = load i32, i32* %B.addr, align 4, !dbg !70
  %cmp25 = icmp sgt i32 %9, 0, !dbg !71
  br i1 %cmp25, label %land.rhs27, label %land.end30, !dbg !72

land.rhs27:                                       ; preds = %land.end19
  %10 = load i32, i32* %C.addr, align 4, !dbg !73
  %cmp28 = icmp sgt i32 %10, 0, !dbg !74
  br label %land.end30

land.end30:                                       ; preds = %land.rhs27, %land.end19
  %11 = phi i1 [ false, %land.end19 ], [ %cmp28, %land.rhs27 ]
  %lnot31 = xor i1 %11, true, !dbg !75
  %lnot.ext32 = zext i1 %lnot31 to i32, !dbg !75
  %cmp33 = icmp eq i32 %lnot.ext32, 1, !dbg !76
  %conv34 = zext i1 %cmp33 to i32, !dbg !76
  %call35 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv34), !dbg !77
  %12 = load i32, i32* %B.addr, align 4, !dbg !78
  %cmp36 = icmp sgt i32 %12, 0, !dbg !79
  br i1 %cmp36, label %land.rhs38, label %land.end41, !dbg !80

land.rhs38:                                       ; preds = %land.end30
  %13 = load i32, i32* %D.addr, align 4, !dbg !81
  %cmp39 = icmp sgt i32 %13, 0, !dbg !82
  br label %land.end41

land.end41:                                       ; preds = %land.rhs38, %land.end30
  %14 = phi i1 [ false, %land.end30 ], [ %cmp39, %land.rhs38 ]
  %lnot42 = xor i1 %14, true, !dbg !83
  %lnot.ext43 = zext i1 %lnot42 to i32, !dbg !83
  %cmp44 = icmp eq i32 %lnot.ext43, 0, !dbg !84
  %conv45 = zext i1 %cmp44 to i32, !dbg !84
  %call46 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv45), !dbg !85
  %15 = load i32, i32* %C.addr, align 4, !dbg !86
  %cmp47 = icmp sgt i32 %15, 0, !dbg !87
  br i1 %cmp47, label %land.rhs49, label %land.end52, !dbg !88

land.rhs49:                                       ; preds = %land.end41
  %16 = load i32, i32* %D.addr, align 4, !dbg !89
  %cmp50 = icmp sgt i32 %16, 0, !dbg !90
  br label %land.end52

land.end52:                                       ; preds = %land.rhs49, %land.end41
  %17 = phi i1 [ false, %land.end41 ], [ %cmp50, %land.rhs49 ]
  %lnot53 = xor i1 %17, true, !dbg !91
  %lnot.ext54 = zext i1 %lnot53 to i32, !dbg !91
  %cmp55 = icmp eq i32 %lnot.ext54, 1, !dbg !92
  %conv56 = zext i1 %cmp55 to i32, !dbg !92
  %call57 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv56), !dbg !93
  ret void, !dbg !94
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !95 {
entry:
  %retval = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @testBitWiseNot(i32 1, i32 2, i32 -3, i32 5), !dbg !98
  call void @testBooleanNot(i32 1, i32 2, i32 -3, i32 5), !dbg !99
  ret i32 0, !dbg !100
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "2002-05-03-NotTest.c", directory: "/home/ubuntu/llvm2goto/regression/llvm_test_suit/single_source/unit-tests")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final)"}
!7 = distinct !DISubprogram(name: "testBitWiseNot", scope: !1, file: !1, line: 4, type: !8, isLocal: false, isDefinition: true, scopeLine: 4, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{null, !10, !10, !10, !10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "A", arg: 1, scope: !7, file: !1, line: 4, type: !10)
!12 = !DIExpression()
!13 = !DILocation(line: 4, column: 25, scope: !7)
!14 = !DILocalVariable(name: "B", arg: 2, scope: !7, file: !1, line: 4, type: !10)
!15 = !DILocation(line: 4, column: 32, scope: !7)
!16 = !DILocalVariable(name: "C", arg: 3, scope: !7, file: !1, line: 4, type: !10)
!17 = !DILocation(line: 4, column: 39, scope: !7)
!18 = !DILocalVariable(name: "D", arg: 4, scope: !7, file: !1, line: 4, type: !10)
!19 = !DILocation(line: 4, column: 46, scope: !7)
!20 = !DILocation(line: 6, column: 11, scope: !7)
!21 = !DILocation(line: 6, column: 10, scope: !7)
!22 = !DILocation(line: 6, column: 13, scope: !7)
!23 = !DILocation(line: 6, column: 3, scope: !7)
!24 = !DILocation(line: 7, column: 11, scope: !7)
!25 = !DILocation(line: 7, column: 10, scope: !7)
!26 = !DILocation(line: 7, column: 13, scope: !7)
!27 = !DILocation(line: 7, column: 3, scope: !7)
!28 = !DILocation(line: 8, column: 11, scope: !7)
!29 = !DILocation(line: 8, column: 10, scope: !7)
!30 = !DILocation(line: 8, column: 13, scope: !7)
!31 = !DILocation(line: 8, column: 3, scope: !7)
!32 = !DILocation(line: 9, column: 11, scope: !7)
!33 = !DILocation(line: 9, column: 10, scope: !7)
!34 = !DILocation(line: 9, column: 13, scope: !7)
!35 = !DILocation(line: 9, column: 3, scope: !7)
!36 = !DILocation(line: 10, column: 1, scope: !7)
!37 = distinct !DISubprogram(name: "testBooleanNot", scope: !1, file: !1, line: 12, type: !8, isLocal: false, isDefinition: true, scopeLine: 12, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!38 = !DILocalVariable(name: "A", arg: 1, scope: !37, file: !1, line: 12, type: !10)
!39 = !DILocation(line: 12, column: 25, scope: !37)
!40 = !DILocalVariable(name: "B", arg: 2, scope: !37, file: !1, line: 12, type: !10)
!41 = !DILocation(line: 12, column: 32, scope: !37)
!42 = !DILocalVariable(name: "C", arg: 3, scope: !37, file: !1, line: 12, type: !10)
!43 = !DILocation(line: 12, column: 39, scope: !37)
!44 = !DILocalVariable(name: "D", arg: 4, scope: !37, file: !1, line: 12, type: !10)
!45 = !DILocation(line: 12, column: 46, scope: !37)
!46 = !DILocation(line: 14, column: 12, scope: !37)
!47 = !DILocation(line: 14, column: 14, scope: !37)
!48 = !DILocation(line: 14, column: 18, scope: !37)
!49 = !DILocation(line: 14, column: 21, scope: !37)
!50 = !DILocation(line: 14, column: 23, scope: !37)
!51 = !DILocation(line: 14, column: 10, scope: !37)
!52 = !DILocation(line: 14, column: 28, scope: !37)
!53 = !DILocation(line: 14, column: 3, scope: !37)
!54 = !DILocation(line: 15, column: 12, scope: !37)
!55 = !DILocation(line: 15, column: 14, scope: !37)
!56 = !DILocation(line: 15, column: 18, scope: !37)
!57 = !DILocation(line: 15, column: 21, scope: !37)
!58 = !DILocation(line: 15, column: 23, scope: !37)
!59 = !DILocation(line: 15, column: 10, scope: !37)
!60 = !DILocation(line: 15, column: 28, scope: !37)
!61 = !DILocation(line: 15, column: 3, scope: !37)
!62 = !DILocation(line: 16, column: 12, scope: !37)
!63 = !DILocation(line: 16, column: 14, scope: !37)
!64 = !DILocation(line: 16, column: 18, scope: !37)
!65 = !DILocation(line: 16, column: 21, scope: !37)
!66 = !DILocation(line: 16, column: 23, scope: !37)
!67 = !DILocation(line: 16, column: 10, scope: !37)
!68 = !DILocation(line: 16, column: 28, scope: !37)
!69 = !DILocation(line: 16, column: 3, scope: !37)
!70 = !DILocation(line: 17, column: 12, scope: !37)
!71 = !DILocation(line: 17, column: 14, scope: !37)
!72 = !DILocation(line: 17, column: 18, scope: !37)
!73 = !DILocation(line: 17, column: 21, scope: !37)
!74 = !DILocation(line: 17, column: 23, scope: !37)
!75 = !DILocation(line: 17, column: 10, scope: !37)
!76 = !DILocation(line: 17, column: 28, scope: !37)
!77 = !DILocation(line: 17, column: 3, scope: !37)
!78 = !DILocation(line: 18, column: 12, scope: !37)
!79 = !DILocation(line: 18, column: 14, scope: !37)
!80 = !DILocation(line: 18, column: 18, scope: !37)
!81 = !DILocation(line: 18, column: 21, scope: !37)
!82 = !DILocation(line: 18, column: 23, scope: !37)
!83 = !DILocation(line: 18, column: 10, scope: !37)
!84 = !DILocation(line: 18, column: 28, scope: !37)
!85 = !DILocation(line: 18, column: 3, scope: !37)
!86 = !DILocation(line: 19, column: 12, scope: !37)
!87 = !DILocation(line: 19, column: 14, scope: !37)
!88 = !DILocation(line: 19, column: 18, scope: !37)
!89 = !DILocation(line: 19, column: 21, scope: !37)
!90 = !DILocation(line: 19, column: 23, scope: !37)
!91 = !DILocation(line: 19, column: 10, scope: !37)
!92 = !DILocation(line: 19, column: 28, scope: !37)
!93 = !DILocation(line: 19, column: 3, scope: !37)
!94 = !DILocation(line: 21, column: 1, scope: !37)
!95 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 23, type: !96, isLocal: false, isDefinition: true, scopeLine: 23, isOptimized: false, unit: !0, variables: !2)
!96 = !DISubroutineType(types: !97)
!97 = !{!10}
!98 = !DILocation(line: 24, column: 3, scope: !95)
!99 = !DILocation(line: 25, column: 3, scope: !95)
!100 = !DILocation(line: 26, column: 3, scope: !95)
