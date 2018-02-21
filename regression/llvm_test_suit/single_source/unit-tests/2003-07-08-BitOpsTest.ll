; ModuleID = '2003-07-08-BitOpsTest.c'
source_filename = "2003-07-08-BitOpsTest.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define void @test(i32 %A, i32 %B, i32 %C, i32 %D) #0 !dbg !7 {
entry:
  %A.addr = alloca i32, align 4
  %B.addr = alloca i32, align 4
  %C.addr = alloca i32, align 4
  %D.addr = alloca i32, align 4
  %bxor = alloca i32, align 4
  %bor = alloca i32, align 4
  %band = alloca i32, align 4
  %bandnot = alloca i32, align 4
  %bornot = alloca i32, align 4
  store i32 %A, i32* %A.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %A.addr, metadata !11, metadata !12), !dbg !13
  store i32 %B, i32* %B.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %B.addr, metadata !14, metadata !12), !dbg !15
  store i32 %C, i32* %C.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %C.addr, metadata !16, metadata !12), !dbg !17
  store i32 %D, i32* %D.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %D.addr, metadata !18, metadata !12), !dbg !19
  call void @llvm.dbg.declare(metadata i32* %bxor, metadata !20, metadata !12), !dbg !21
  %0 = load i32, i32* %A.addr, align 4, !dbg !22
  %1 = load i32, i32* %B.addr, align 4, !dbg !23
  %xor = xor i32 %0, %1, !dbg !24
  %2 = load i32, i32* %C.addr, align 4, !dbg !25
  %xor1 = xor i32 %xor, %2, !dbg !26
  %3 = load i32, i32* %D.addr, align 4, !dbg !27
  %xor2 = xor i32 %xor1, %3, !dbg !28
  store i32 %xor2, i32* %bxor, align 4, !dbg !21
  call void @llvm.dbg.declare(metadata i32* %bor, metadata !29, metadata !12), !dbg !30
  %4 = load i32, i32* %A.addr, align 4, !dbg !31
  %5 = load i32, i32* %B.addr, align 4, !dbg !32
  %or = or i32 %4, %5, !dbg !33
  %6 = load i32, i32* %C.addr, align 4, !dbg !34
  %or3 = or i32 %or, %6, !dbg !35
  %7 = load i32, i32* %D.addr, align 4, !dbg !36
  %or4 = or i32 %or3, %7, !dbg !37
  store i32 %or4, i32* %bor, align 4, !dbg !30
  call void @llvm.dbg.declare(metadata i32* %band, metadata !38, metadata !12), !dbg !39
  %8 = load i32, i32* %A.addr, align 4, !dbg !40
  %9 = load i32, i32* %B.addr, align 4, !dbg !41
  %and = and i32 %8, %9, !dbg !42
  %10 = load i32, i32* %C.addr, align 4, !dbg !43
  %and5 = and i32 %and, %10, !dbg !44
  %11 = load i32, i32* %D.addr, align 4, !dbg !45
  %and6 = and i32 %and5, %11, !dbg !46
  store i32 %and6, i32* %band, align 4, !dbg !39
  call void @llvm.dbg.declare(metadata i32* %bandnot, metadata !47, metadata !12), !dbg !48
  %12 = load i32, i32* %A.addr, align 4, !dbg !49
  %13 = load i32, i32* %B.addr, align 4, !dbg !50
  %neg = xor i32 %13, -1, !dbg !51
  %and7 = and i32 %12, %neg, !dbg !52
  %14 = load i32, i32* %C.addr, align 4, !dbg !53
  %15 = load i32, i32* %D.addr, align 4, !dbg !54
  %neg8 = xor i32 %15, -1, !dbg !55
  %and9 = and i32 %14, %neg8, !dbg !56
  %xor10 = xor i32 %and7, %and9, !dbg !57
  store i32 %xor10, i32* %bandnot, align 4, !dbg !48
  call void @llvm.dbg.declare(metadata i32* %bornot, metadata !58, metadata !12), !dbg !59
  %16 = load i32, i32* %A.addr, align 4, !dbg !60
  %17 = load i32, i32* %B.addr, align 4, !dbg !61
  %neg11 = xor i32 %17, -1, !dbg !62
  %or12 = or i32 %16, %neg11, !dbg !63
  %18 = load i32, i32* %C.addr, align 4, !dbg !64
  %19 = load i32, i32* %D.addr, align 4, !dbg !65
  %neg13 = xor i32 %19, -1, !dbg !66
  %or14 = or i32 %18, %neg13, !dbg !67
  %xor15 = xor i32 %or12, %or14, !dbg !68
  store i32 %xor15, i32* %bornot, align 4, !dbg !59
  %20 = load i32, i32* %bxor, align 4, !dbg !69
  %cmp = icmp eq i32 %20, -15, !dbg !70
  %conv = zext i1 %cmp to i32, !dbg !70
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !71
  %21 = load i32, i32* %bor, align 4, !dbg !72
  %cmp16 = icmp eq i32 %21, -1, !dbg !73
  %conv17 = zext i1 %cmp16 to i32, !dbg !73
  %call18 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv17), !dbg !74
  %22 = load i32, i32* %band, align 4, !dbg !75
  %cmp19 = icmp eq i32 %22, 0, !dbg !76
  %conv20 = zext i1 %cmp19 to i32, !dbg !76
  %call21 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv20), !dbg !77
  %23 = load i32, i32* %bandnot, align 4, !dbg !78
  %cmp22 = icmp eq i32 %23, -3, !dbg !79
  %conv23 = zext i1 %cmp22 to i32, !dbg !79
  %call24 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv23), !dbg !80
  %24 = load i32, i32* %bornot, align 4, !dbg !81
  %cmp25 = icmp eq i32 %24, 12, !dbg !82
  %conv26 = zext i1 %cmp25 to i32, !dbg !82
  %call27 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv26), !dbg !83
  ret void, !dbg !84
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i32 @assert(...) #2

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !85 {
entry:
  %retval = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @test(i32 7, i32 8, i32 -5, i32 5), !dbg !88
  ret i32 0, !dbg !89
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "2003-07-08-BitOpsTest.c", directory: "/home/ubuntu/llvm2goto/regression/llvm_test_suit/single_source/unit-tests")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final)"}
!7 = distinct !DISubprogram(name: "test", scope: !1, file: !1, line: 3, type: !8, isLocal: false, isDefinition: true, scopeLine: 3, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{null, !10, !10, !10, !10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "A", arg: 1, scope: !7, file: !1, line: 3, type: !10)
!12 = !DIExpression()
!13 = !DILocation(line: 3, column: 15, scope: !7)
!14 = !DILocalVariable(name: "B", arg: 2, scope: !7, file: !1, line: 3, type: !10)
!15 = !DILocation(line: 3, column: 22, scope: !7)
!16 = !DILocalVariable(name: "C", arg: 3, scope: !7, file: !1, line: 3, type: !10)
!17 = !DILocation(line: 3, column: 29, scope: !7)
!18 = !DILocalVariable(name: "D", arg: 4, scope: !7, file: !1, line: 3, type: !10)
!19 = !DILocation(line: 3, column: 36, scope: !7)
!20 = !DILocalVariable(name: "bxor", scope: !7, file: !1, line: 4, type: !10)
!21 = !DILocation(line: 4, column: 7, scope: !7)
!22 = !DILocation(line: 4, column: 14, scope: !7)
!23 = !DILocation(line: 4, column: 18, scope: !7)
!24 = !DILocation(line: 4, column: 16, scope: !7)
!25 = !DILocation(line: 4, column: 22, scope: !7)
!26 = !DILocation(line: 4, column: 20, scope: !7)
!27 = !DILocation(line: 4, column: 26, scope: !7)
!28 = !DILocation(line: 4, column: 24, scope: !7)
!29 = !DILocalVariable(name: "bor", scope: !7, file: !1, line: 5, type: !10)
!30 = !DILocation(line: 5, column: 7, scope: !7)
!31 = !DILocation(line: 5, column: 14, scope: !7)
!32 = !DILocation(line: 5, column: 18, scope: !7)
!33 = !DILocation(line: 5, column: 16, scope: !7)
!34 = !DILocation(line: 5, column: 22, scope: !7)
!35 = !DILocation(line: 5, column: 20, scope: !7)
!36 = !DILocation(line: 5, column: 26, scope: !7)
!37 = !DILocation(line: 5, column: 24, scope: !7)
!38 = !DILocalVariable(name: "band", scope: !7, file: !1, line: 6, type: !10)
!39 = !DILocation(line: 6, column: 7, scope: !7)
!40 = !DILocation(line: 6, column: 14, scope: !7)
!41 = !DILocation(line: 6, column: 18, scope: !7)
!42 = !DILocation(line: 6, column: 16, scope: !7)
!43 = !DILocation(line: 6, column: 22, scope: !7)
!44 = !DILocation(line: 6, column: 20, scope: !7)
!45 = !DILocation(line: 6, column: 26, scope: !7)
!46 = !DILocation(line: 6, column: 24, scope: !7)
!47 = !DILocalVariable(name: "bandnot", scope: !7, file: !1, line: 7, type: !10)
!48 = !DILocation(line: 7, column: 7, scope: !7)
!49 = !DILocation(line: 7, column: 18, scope: !7)
!50 = !DILocation(line: 7, column: 23, scope: !7)
!51 = !DILocation(line: 7, column: 22, scope: !7)
!52 = !DILocation(line: 7, column: 20, scope: !7)
!53 = !DILocation(line: 7, column: 29, scope: !7)
!54 = !DILocation(line: 7, column: 34, scope: !7)
!55 = !DILocation(line: 7, column: 33, scope: !7)
!56 = !DILocation(line: 7, column: 31, scope: !7)
!57 = !DILocation(line: 7, column: 26, scope: !7)
!58 = !DILocalVariable(name: "bornot", scope: !7, file: !1, line: 8, type: !10)
!59 = !DILocation(line: 8, column: 7, scope: !7)
!60 = !DILocation(line: 8, column: 18, scope: !7)
!61 = !DILocation(line: 8, column: 23, scope: !7)
!62 = !DILocation(line: 8, column: 22, scope: !7)
!63 = !DILocation(line: 8, column: 20, scope: !7)
!64 = !DILocation(line: 8, column: 29, scope: !7)
!65 = !DILocation(line: 8, column: 34, scope: !7)
!66 = !DILocation(line: 8, column: 33, scope: !7)
!67 = !DILocation(line: 8, column: 31, scope: !7)
!68 = !DILocation(line: 8, column: 26, scope: !7)
!69 = !DILocation(line: 11, column: 10, scope: !7)
!70 = !DILocation(line: 11, column: 15, scope: !7)
!71 = !DILocation(line: 11, column: 3, scope: !7)
!72 = !DILocation(line: 12, column: 10, scope: !7)
!73 = !DILocation(line: 12, column: 14, scope: !7)
!74 = !DILocation(line: 12, column: 3, scope: !7)
!75 = !DILocation(line: 13, column: 10, scope: !7)
!76 = !DILocation(line: 13, column: 15, scope: !7)
!77 = !DILocation(line: 13, column: 3, scope: !7)
!78 = !DILocation(line: 14, column: 10, scope: !7)
!79 = !DILocation(line: 14, column: 18, scope: !7)
!80 = !DILocation(line: 14, column: 3, scope: !7)
!81 = !DILocation(line: 15, column: 10, scope: !7)
!82 = !DILocation(line: 15, column: 17, scope: !7)
!83 = !DILocation(line: 15, column: 3, scope: !7)
!84 = !DILocation(line: 16, column: 1, scope: !7)
!85 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 18, type: !86, isLocal: false, isDefinition: true, scopeLine: 18, isOptimized: false, unit: !0, variables: !2)
!86 = !DISubroutineType(types: !87)
!87 = !{!10}
!88 = !DILocation(line: 19, column: 3, scope: !85)
!89 = !DILocation(line: 20, column: 3, scope: !85)
