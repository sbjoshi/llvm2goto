; ModuleID = '2003-07-06-IntOverflow.c'
source_filename = "2003-07-06-IntOverflow.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define void @compareOvf(i32 %x, i32 %y) #0 !dbg !7 {
entry:
  %x.addr = alloca i32, align 4
  %y.addr = alloca i32, align 4
  %sum = alloca i32, align 4
  store i32 %x, i32* %x.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %x.addr, metadata !11, metadata !12), !dbg !13
  store i32 %y, i32* %y.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %y.addr, metadata !14, metadata !12), !dbg !15
  call void @llvm.dbg.declare(metadata i32* %sum, metadata !16, metadata !12), !dbg !17
  %0 = load i32, i32* %x.addr, align 4, !dbg !18
  %1 = load i32, i32* %x.addr, align 4, !dbg !19
  %mul = mul nsw i32 %0, %1, !dbg !20
  %2 = load i32, i32* %y.addr, align 4, !dbg !21
  %3 = load i32, i32* %y.addr, align 4, !dbg !22
  %mul1 = mul nsw i32 %2, %3, !dbg !23
  %add = add nsw i32 %mul, %mul1, !dbg !24
  store i32 %add, i32* %sum, align 4, !dbg !17
  %4 = load i32, i32* %sum, align 4, !dbg !25
  %cmp = icmp slt i32 %4, 4194304, !dbg !26
  %conv = zext i1 %cmp to i32, !dbg !26
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !27
  ret void, !dbg !28
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i32 @assert(...) #2

; Function Attrs: noinline nounwind optnone uwtable
define void @divideOvf(i32 %x, i32 %y) #0 !dbg !29 {
entry:
  %x.addr = alloca i32, align 4
  %y.addr = alloca i32, align 4
  %sum = alloca i32, align 4
  %rem = alloca i32, align 4
  store i32 %x, i32* %x.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %x.addr, metadata !30, metadata !12), !dbg !31
  store i32 %y, i32* %y.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %y.addr, metadata !32, metadata !12), !dbg !33
  call void @llvm.dbg.declare(metadata i32* %sum, metadata !34, metadata !12), !dbg !35
  %0 = load i32, i32* %x.addr, align 4, !dbg !36
  %1 = load i32, i32* %x.addr, align 4, !dbg !37
  %mul = mul nsw i32 %0, %1, !dbg !38
  %2 = load i32, i32* %y.addr, align 4, !dbg !39
  %3 = load i32, i32* %y.addr, align 4, !dbg !40
  %mul1 = mul nsw i32 %2, %3, !dbg !41
  %add = add nsw i32 %mul, %mul1, !dbg !42
  store i32 %add, i32* %sum, align 4, !dbg !35
  call void @llvm.dbg.declare(metadata i32* %rem, metadata !43, metadata !12), !dbg !44
  %4 = load i32, i32* %sum, align 4, !dbg !45
  %div = sdiv i32 -2147483648, %4, !dbg !46
  store i32 %div, i32* %rem, align 4, !dbg !44
  %5 = load i32, i32* %rem, align 4, !dbg !47
  %cmp = icmp eq i32 %5, -170, !dbg !48
  %conv = zext i1 %cmp to i32, !dbg !48
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !49
  ret void, !dbg !50
}

; Function Attrs: noinline nounwind optnone uwtable
define void @divideNeg(i32 %x, i32 %y) #0 !dbg !51 {
entry:
  %x.addr = alloca i32, align 4
  %y.addr = alloca i32, align 4
  %sum = alloca i32, align 4
  %rem = alloca i32, align 4
  store i32 %x, i32* %x.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %x.addr, metadata !52, metadata !12), !dbg !53
  store i32 %y, i32* %y.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %y.addr, metadata !54, metadata !12), !dbg !55
  call void @llvm.dbg.declare(metadata i32* %sum, metadata !56, metadata !12), !dbg !57
  %0 = load i32, i32* %x.addr, align 4, !dbg !58
  %1 = load i32, i32* %x.addr, align 4, !dbg !59
  %mul = mul nsw i32 %0, %1, !dbg !60
  %2 = load i32, i32* %y.addr, align 4, !dbg !61
  %3 = load i32, i32* %y.addr, align 4, !dbg !62
  %mul1 = mul nsw i32 %2, %3, !dbg !63
  %sub = sub nsw i32 %mul, %mul1, !dbg !64
  store i32 %sub, i32* %sum, align 4, !dbg !57
  call void @llvm.dbg.declare(metadata i32* %rem, metadata !65, metadata !12), !dbg !66
  %4 = load i32, i32* %sum, align 4, !dbg !67
  %div = sdiv i32 %4, 262144, !dbg !68
  store i32 %div, i32* %rem, align 4, !dbg !66
  %5 = load i32, i32* %rem, align 4, !dbg !69
  %cmp = icmp eq i32 %5, -16, !dbg !70
  %conv = zext i1 %cmp to i32, !dbg !70
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !71
  ret void, !dbg !72
}

; Function Attrs: noinline nounwind optnone uwtable
define void @subtractOvf(i32 %x, i32 %y) #0 !dbg !73 {
entry:
  %x.addr = alloca i32, align 4
  %y.addr = alloca i32, align 4
  %sum = alloca i32, align 4
  %rem = alloca i32, align 4
  store i32 %x, i32* %x.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %x.addr, metadata !74, metadata !12), !dbg !75
  store i32 %y, i32* %y.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %y.addr, metadata !76, metadata !12), !dbg !77
  call void @llvm.dbg.declare(metadata i32* %sum, metadata !78, metadata !12), !dbg !79
  %0 = load i32, i32* %x.addr, align 4, !dbg !80
  %1 = load i32, i32* %x.addr, align 4, !dbg !81
  %mul = mul nsw i32 %0, %1, !dbg !82
  %2 = load i32, i32* %y.addr, align 4, !dbg !83
  %3 = load i32, i32* %y.addr, align 4, !dbg !84
  %mul1 = mul nsw i32 %2, %3, !dbg !85
  %add = add nsw i32 %mul, %mul1, !dbg !86
  store i32 %add, i32* %sum, align 4, !dbg !79
  call void @llvm.dbg.declare(metadata i32* %rem, metadata !87, metadata !12), !dbg !88
  %4 = load i32, i32* %sum, align 4, !dbg !89
  %sub = sub i32 -2147483648, %4, !dbg !90
  store i32 %sub, i32* %rem, align 4, !dbg !88
  %5 = load i32, i32* %rem, align 4, !dbg !91
  %cmp = icmp eq i32 %5, 2134900731, !dbg !92
  %conv = zext i1 %cmp to i32, !dbg !92
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !93
  ret void, !dbg !94
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !95 {
entry:
  %retval = alloca i32, align 4
  %b21 = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %b21, metadata !98, metadata !12), !dbg !99
  store i32 2097152, i32* %b21, align 4, !dbg !99
  %0 = load i32, i32* %b21, align 4, !dbg !100
  %1 = load i32, i32* %b21, align 4, !dbg !101
  call void @compareOvf(i32 %0, i32 %1), !dbg !102
  %2 = load i32, i32* %b21, align 4, !dbg !103
  %add = add nsw i32 %2, 1, !dbg !104
  %3 = load i32, i32* %b21, align 4, !dbg !105
  %add1 = add nsw i32 %3, 2, !dbg !106
  call void @divideOvf(i32 %add, i32 %add1), !dbg !107
  %4 = load i32, i32* %b21, align 4, !dbg !108
  %add2 = add nsw i32 %4, 1, !dbg !109
  %5 = load i32, i32* %b21, align 4, !dbg !110
  %add3 = add nsw i32 %5, 2, !dbg !111
  call void @divideNeg(i32 %add2, i32 %add3), !dbg !112
  %6 = load i32, i32* %b21, align 4, !dbg !113
  %add4 = add nsw i32 %6, 1, !dbg !114
  %7 = load i32, i32* %b21, align 4, !dbg !115
  %add5 = add nsw i32 %7, 2, !dbg !116
  call void @subtractOvf(i32 %add4, i32 %add5), !dbg !117
  ret i32 0, !dbg !118
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "2003-07-06-IntOverflow.c", directory: "/home/ubuntu/llvm2goto/regression/llvm_test_suit/single_source/unit-tests")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final)"}
!7 = distinct !DISubprogram(name: "compareOvf", scope: !1, file: !1, line: 15, type: !8, isLocal: false, isDefinition: true, scopeLine: 16, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{null, !10, !10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "x", arg: 1, scope: !7, file: !1, line: 15, type: !10)
!12 = !DIExpression()
!13 = !DILocation(line: 15, column: 21, scope: !7)
!14 = !DILocalVariable(name: "y", arg: 2, scope: !7, file: !1, line: 15, type: !10)
!15 = !DILocation(line: 15, column: 28, scope: !7)
!16 = !DILocalVariable(name: "sum", scope: !7, file: !1, line: 17, type: !10)
!17 = !DILocation(line: 17, column: 7, scope: !7)
!18 = !DILocation(line: 17, column: 13, scope: !7)
!19 = !DILocation(line: 17, column: 17, scope: !7)
!20 = !DILocation(line: 17, column: 15, scope: !7)
!21 = !DILocation(line: 17, column: 21, scope: !7)
!22 = !DILocation(line: 17, column: 25, scope: !7)
!23 = !DILocation(line: 17, column: 23, scope: !7)
!24 = !DILocation(line: 17, column: 19, scope: !7)
!25 = !DILocation(line: 22, column: 10, scope: !7)
!26 = !DILocation(line: 22, column: 14, scope: !7)
!27 = !DILocation(line: 22, column: 3, scope: !7)
!28 = !DILocation(line: 23, column: 1, scope: !7)
!29 = distinct !DISubprogram(name: "divideOvf", scope: !1, file: !1, line: 25, type: !8, isLocal: false, isDefinition: true, scopeLine: 26, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!30 = !DILocalVariable(name: "x", arg: 1, scope: !29, file: !1, line: 25, type: !10)
!31 = !DILocation(line: 25, column: 20, scope: !29)
!32 = !DILocalVariable(name: "y", arg: 2, scope: !29, file: !1, line: 25, type: !10)
!33 = !DILocation(line: 25, column: 27, scope: !29)
!34 = !DILocalVariable(name: "sum", scope: !29, file: !1, line: 27, type: !10)
!35 = !DILocation(line: 27, column: 7, scope: !29)
!36 = !DILocation(line: 27, column: 13, scope: !29)
!37 = !DILocation(line: 27, column: 17, scope: !29)
!38 = !DILocation(line: 27, column: 15, scope: !29)
!39 = !DILocation(line: 27, column: 21, scope: !29)
!40 = !DILocation(line: 27, column: 25, scope: !29)
!41 = !DILocation(line: 27, column: 23, scope: !29)
!42 = !DILocation(line: 27, column: 19, scope: !29)
!43 = !DILocalVariable(name: "rem", scope: !29, file: !1, line: 28, type: !10)
!44 = !DILocation(line: 28, column: 7, scope: !29)
!45 = !DILocation(line: 28, column: 25, scope: !29)
!46 = !DILocation(line: 28, column: 23, scope: !29)
!47 = !DILocation(line: 30, column: 10, scope: !29)
!48 = !DILocation(line: 30, column: 14, scope: !29)
!49 = !DILocation(line: 30, column: 3, scope: !29)
!50 = !DILocation(line: 31, column: 1, scope: !29)
!51 = distinct !DISubprogram(name: "divideNeg", scope: !1, file: !1, line: 33, type: !8, isLocal: false, isDefinition: true, scopeLine: 34, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!52 = !DILocalVariable(name: "x", arg: 1, scope: !51, file: !1, line: 33, type: !10)
!53 = !DILocation(line: 33, column: 20, scope: !51)
!54 = !DILocalVariable(name: "y", arg: 2, scope: !51, file: !1, line: 33, type: !10)
!55 = !DILocation(line: 33, column: 27, scope: !51)
!56 = !DILocalVariable(name: "sum", scope: !51, file: !1, line: 35, type: !10)
!57 = !DILocation(line: 35, column: 7, scope: !51)
!58 = !DILocation(line: 35, column: 13, scope: !51)
!59 = !DILocation(line: 35, column: 17, scope: !51)
!60 = !DILocation(line: 35, column: 15, scope: !51)
!61 = !DILocation(line: 35, column: 21, scope: !51)
!62 = !DILocation(line: 35, column: 25, scope: !51)
!63 = !DILocation(line: 35, column: 23, scope: !51)
!64 = !DILocation(line: 35, column: 19, scope: !51)
!65 = !DILocalVariable(name: "rem", scope: !51, file: !1, line: 36, type: !10)
!66 = !DILocation(line: 36, column: 7, scope: !51)
!67 = !DILocation(line: 36, column: 13, scope: !51)
!68 = !DILocation(line: 36, column: 17, scope: !51)
!69 = !DILocation(line: 38, column: 10, scope: !51)
!70 = !DILocation(line: 38, column: 14, scope: !51)
!71 = !DILocation(line: 38, column: 3, scope: !51)
!72 = !DILocation(line: 39, column: 1, scope: !51)
!73 = distinct !DISubprogram(name: "subtractOvf", scope: !1, file: !1, line: 41, type: !8, isLocal: false, isDefinition: true, scopeLine: 42, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!74 = !DILocalVariable(name: "x", arg: 1, scope: !73, file: !1, line: 41, type: !10)
!75 = !DILocation(line: 41, column: 22, scope: !73)
!76 = !DILocalVariable(name: "y", arg: 2, scope: !73, file: !1, line: 41, type: !10)
!77 = !DILocation(line: 41, column: 29, scope: !73)
!78 = !DILocalVariable(name: "sum", scope: !73, file: !1, line: 43, type: !10)
!79 = !DILocation(line: 43, column: 7, scope: !73)
!80 = !DILocation(line: 43, column: 13, scope: !73)
!81 = !DILocation(line: 43, column: 17, scope: !73)
!82 = !DILocation(line: 43, column: 15, scope: !73)
!83 = !DILocation(line: 43, column: 21, scope: !73)
!84 = !DILocation(line: 43, column: 25, scope: !73)
!85 = !DILocation(line: 43, column: 23, scope: !73)
!86 = !DILocation(line: 43, column: 19, scope: !73)
!87 = !DILocalVariable(name: "rem", scope: !73, file: !1, line: 44, type: !10)
!88 = !DILocation(line: 44, column: 7, scope: !73)
!89 = !DILocation(line: 44, column: 26, scope: !73)
!90 = !DILocation(line: 44, column: 24, scope: !73)
!91 = !DILocation(line: 46, column: 10, scope: !73)
!92 = !DILocation(line: 46, column: 14, scope: !73)
!93 = !DILocation(line: 46, column: 3, scope: !73)
!94 = !DILocation(line: 47, column: 1, scope: !73)
!95 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 49, type: !96, isLocal: false, isDefinition: true, scopeLine: 50, isOptimized: false, unit: !0, variables: !2)
!96 = !DISubroutineType(types: !97)
!97 = !{!10}
!98 = !DILocalVariable(name: "b21", scope: !95, file: !1, line: 51, type: !10)
!99 = !DILocation(line: 51, column: 7, scope: !95)
!100 = !DILocation(line: 52, column: 14, scope: !95)
!101 = !DILocation(line: 52, column: 25, scope: !95)
!102 = !DILocation(line: 52, column: 3, scope: !95)
!103 = !DILocation(line: 53, column: 13, scope: !95)
!104 = !DILocation(line: 53, column: 17, scope: !95)
!105 = !DILocation(line: 53, column: 25, scope: !95)
!106 = !DILocation(line: 53, column: 29, scope: !95)
!107 = !DILocation(line: 53, column: 3, scope: !95)
!108 = !DILocation(line: 54, column: 13, scope: !95)
!109 = !DILocation(line: 54, column: 17, scope: !95)
!110 = !DILocation(line: 54, column: 25, scope: !95)
!111 = !DILocation(line: 54, column: 29, scope: !95)
!112 = !DILocation(line: 54, column: 3, scope: !95)
!113 = !DILocation(line: 55, column: 15, scope: !95)
!114 = !DILocation(line: 55, column: 19, scope: !95)
!115 = !DILocation(line: 55, column: 25, scope: !95)
!116 = !DILocation(line: 55, column: 29, scope: !95)
!117 = !DILocation(line: 55, column: 3, scope: !95)
!118 = !DILocation(line: 56, column: 3, scope: !95)
