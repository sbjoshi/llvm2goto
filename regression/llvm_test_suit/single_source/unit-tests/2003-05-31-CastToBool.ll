; ModuleID = '2003-05-31-CastToBool.c'
source_filename = "2003-05-31-CastToBool.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [4 x i8] c"%d \00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define void @testCastOps(i32 %y) #0 !dbg !7 {
entry:
  %y.addr = alloca i32, align 4
  store i32 %y, i32* %y.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %y.addr, metadata !11, metadata !12), !dbg !13
  %0 = load i32, i32* %y.addr, align 4, !dbg !14
  %cmp = icmp eq i32 %0, 2, !dbg !15
  br i1 %cmp, label %lor.end, label %lor.rhs, !dbg !16

lor.rhs:                                          ; preds = %entry
  %1 = load i32, i32* %y.addr, align 4, !dbg !17
  %cmp1 = icmp eq i32 %1, 0, !dbg !18
  br label %lor.end, !dbg !16

lor.end:                                          ; preds = %lor.rhs, %entry
  %2 = phi i1 [ true, %entry ], [ %cmp1, %lor.rhs ]
  %lor.ext = zext i1 %2 to i32, !dbg !16
  %cmp2 = icmp eq i32 %lor.ext, 1, !dbg !19
  %conv = zext i1 %cmp2 to i32, !dbg !19
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !20
  %3 = load i32, i32* %y.addr, align 4, !dbg !21
  %cmp3 = icmp sgt i32 %3, 2, !dbg !22
  br i1 %cmp3, label %lor.end8, label %lor.rhs5, !dbg !23

lor.rhs5:                                         ; preds = %lor.end
  %4 = load i32, i32* %y.addr, align 4, !dbg !24
  %cmp6 = icmp slt i32 %4, 5, !dbg !25
  br label %lor.end8, !dbg !23

lor.end8:                                         ; preds = %lor.rhs5, %lor.end
  %5 = phi i1 [ true, %lor.end ], [ %cmp6, %lor.rhs5 ]
  %lor.ext9 = zext i1 %5 to i32, !dbg !23
  %cmp10 = icmp eq i32 %lor.ext9, 0, !dbg !26
  %conv11 = zext i1 %cmp10 to i32, !dbg !26
  %call12 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv11), !dbg !27
  %6 = load i32, i32* %y.addr, align 4, !dbg !28
  %xor = xor i32 %6, 2, !dbg !29
  %7 = load i32, i32* %y.addr, align 4, !dbg !30
  %neg = xor i32 %7, -1, !dbg !31
  %xor13 = xor i32 %xor, %neg, !dbg !32
  %cmp14 = icmp eq i32 %xor13, 1, !dbg !33
  %conv15 = zext i1 %cmp14 to i32, !dbg !33
  %call16 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv15), !dbg !34
  ret void, !dbg !35
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i32 @assert(...) #2

; Function Attrs: noinline nounwind optnone uwtable
define i32 @testBool(i1 zeroext %X) #0 !dbg !36 {
entry:
  %X.addr = alloca i8, align 1
  %frombool = zext i1 %X to i8
  store i8 %frombool, i8* %X.addr, align 1
  call void @llvm.dbg.declare(metadata i8* %X.addr, metadata !40, metadata !12), !dbg !41
  %0 = load i8, i8* %X.addr, align 1, !dbg !42
  %tobool = trunc i8 %0 to i1, !dbg !42
  %conv = zext i1 %tobool to i32, !dbg !42
  ret i32 %conv, !dbg !43
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @testByte(i8 signext %X) #0 !dbg !44 {
entry:
  %X.addr = alloca i8, align 1
  store i8 %X, i8* %X.addr, align 1
  call void @llvm.dbg.declare(metadata i8* %X.addr, metadata !48, metadata !12), !dbg !49
  %0 = load i8, i8* %X.addr, align 1, !dbg !50
  %conv = sext i8 %0 to i32, !dbg !50
  %cmp = icmp ne i32 %conv, 0, !dbg !51
  %call = call i32 @testBool(i1 zeroext %cmp), !dbg !52
  ret i32 %call, !dbg !53
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @testShort(i16 signext %X) #0 !dbg !54 {
entry:
  %X.addr = alloca i16, align 2
  store i16 %X, i16* %X.addr, align 2
  call void @llvm.dbg.declare(metadata i16* %X.addr, metadata !58, metadata !12), !dbg !59
  %0 = load i16, i16* %X.addr, align 2, !dbg !60
  %conv = sext i16 %0 to i32, !dbg !60
  %call = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str, i32 0, i32 0), i32 %conv), !dbg !61
  %1 = load i16, i16* %X.addr, align 2, !dbg !62
  %conv1 = sext i16 %1 to i32, !dbg !62
  %cmp = icmp ne i32 %conv1, 0, !dbg !63
  %call3 = call i32 @testBool(i1 zeroext %cmp), !dbg !64
  ret i32 %call3, !dbg !65
}

declare i32 @printf(i8*, ...) #2

; Function Attrs: noinline nounwind optnone uwtable
define i32 @testInt(i32 %X) #0 !dbg !66 {
entry:
  %X.addr = alloca i32, align 4
  store i32 %X, i32* %X.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %X.addr, metadata !69, metadata !12), !dbg !70
  %0 = load i32, i32* %X.addr, align 4, !dbg !71
  %cmp = icmp ne i32 %0, 0, !dbg !72
  %call = call i32 @testBool(i1 zeroext %cmp), !dbg !73
  ret i32 %call, !dbg !74
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @testLong(i64 %X) #0 !dbg !75 {
entry:
  %X.addr = alloca i64, align 8
  store i64 %X, i64* %X.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %X.addr, metadata !79, metadata !12), !dbg !80
  %0 = load i64, i64* %X.addr, align 8, !dbg !81
  %cmp = icmp ne i64 %0, 0, !dbg !82
  %call = call i32 @testBool(i1 zeroext %cmp), !dbg !83
  ret i32 %call, !dbg !84
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !85 {
entry:
  %retval = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  %call = call i32 @testByte(i8 signext 0), !dbg !88
  %cmp = icmp eq i32 %call, 0, !dbg !89
  %conv = zext i1 %cmp to i32, !dbg !89
  %call1 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !90
  %call2 = call i32 @testByte(i8 signext 123), !dbg !91
  %cmp3 = icmp eq i32 %call2, 1, !dbg !92
  %conv4 = zext i1 %cmp3 to i32, !dbg !92
  %call5 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv4), !dbg !93
  %call6 = call i32 @testShort(i16 signext 0), !dbg !94
  %cmp7 = icmp eq i32 %call6, 0, !dbg !95
  %conv8 = zext i1 %cmp7 to i32, !dbg !95
  %call9 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv8), !dbg !96
  %call10 = call i32 @testShort(i16 signext 1234), !dbg !97
  %cmp11 = icmp eq i32 %call10, 1, !dbg !98
  %conv12 = zext i1 %cmp11 to i32, !dbg !98
  %call13 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv12), !dbg !99
  %call14 = call i32 @testInt(i32 0), !dbg !100
  %cmp15 = icmp eq i32 %call14, 0, !dbg !101
  %conv16 = zext i1 %cmp15 to i32, !dbg !101
  %call17 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv16), !dbg !102
  %call18 = call i32 @testInt(i32 1234), !dbg !103
  %cmp19 = icmp eq i32 %call18, 1, !dbg !104
  %conv20 = zext i1 %cmp19 to i32, !dbg !104
  %call21 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv20), !dbg !105
  %call22 = call i32 @testLong(i64 0), !dbg !106
  %cmp23 = icmp eq i32 %call22, 0, !dbg !107
  %conv24 = zext i1 %cmp23 to i32, !dbg !107
  %call25 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv24), !dbg !108
  %call26 = call i32 @testLong(i64 123121231231231), !dbg !109
  %cmp27 = icmp eq i32 %call26, 1, !dbg !110
  %conv28 = zext i1 %cmp27 to i32, !dbg !110
  %call29 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv28), !dbg !111
  %call30 = call i32 @testLong(i64 1230098424783699968), !dbg !112
  %cmp31 = icmp eq i32 %call30, 1, !dbg !113
  %conv32 = zext i1 %cmp31 to i32, !dbg !113
  %call33 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv32), !dbg !114
  %call34 = call i32 @testLong(i64 69920), !dbg !115
  %cmp35 = icmp eq i32 %call34, 1, !dbg !116
  %conv36 = zext i1 %cmp35 to i32, !dbg !116
  %call37 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv36), !dbg !117
  call void @testCastOps(i32 2), !dbg !118
  ret i32 0, !dbg !119
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "2003-05-31-CastToBool.c", directory: "/home/ubuntu/llvm2goto/regression/llvm_test_suit/single_source/unit-tests")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final)"}
!7 = distinct !DISubprogram(name: "testCastOps", scope: !1, file: !1, line: 3, type: !8, isLocal: false, isDefinition: true, scopeLine: 3, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{null, !10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "y", arg: 1, scope: !7, file: !1, line: 3, type: !10)
!12 = !DIExpression()
!13 = !DILocation(line: 3, column: 22, scope: !7)
!14 = !DILocation(line: 4, column: 11, scope: !7)
!15 = !DILocation(line: 4, column: 13, scope: !7)
!16 = !DILocation(line: 4, column: 18, scope: !7)
!17 = !DILocation(line: 4, column: 21, scope: !7)
!18 = !DILocation(line: 4, column: 23, scope: !7)
!19 = !DILocation(line: 4, column: 29, scope: !7)
!20 = !DILocation(line: 4, column: 3, scope: !7)
!21 = !DILocation(line: 5, column: 11, scope: !7)
!22 = !DILocation(line: 5, column: 13, scope: !7)
!23 = !DILocation(line: 5, column: 17, scope: !7)
!24 = !DILocation(line: 5, column: 20, scope: !7)
!25 = !DILocation(line: 5, column: 22, scope: !7)
!26 = !DILocation(line: 5, column: 27, scope: !7)
!27 = !DILocation(line: 5, column: 3, scope: !7)
!28 = !DILocation(line: 6, column: 11, scope: !7)
!29 = !DILocation(line: 6, column: 13, scope: !7)
!30 = !DILocation(line: 6, column: 20, scope: !7)
!31 = !DILocation(line: 6, column: 19, scope: !7)
!32 = !DILocation(line: 6, column: 17, scope: !7)
!33 = !DILocation(line: 6, column: 23, scope: !7)
!34 = !DILocation(line: 6, column: 3, scope: !7)
!35 = !DILocation(line: 13, column: 1, scope: !7)
!36 = distinct !DISubprogram(name: "testBool", scope: !1, file: !1, line: 15, type: !37, isLocal: false, isDefinition: true, scopeLine: 15, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!37 = !DISubroutineType(types: !38)
!38 = !{!10, !39}
!39 = !DIBasicType(name: "_Bool", size: 8, encoding: DW_ATE_boolean)
!40 = !DILocalVariable(name: "X", arg: 1, scope: !36, file: !1, line: 15, type: !39)
!41 = !DILocation(line: 15, column: 20, scope: !36)
!42 = !DILocation(line: 17, column: 10, scope: !36)
!43 = !DILocation(line: 17, column: 3, scope: !36)
!44 = distinct !DISubprogram(name: "testByte", scope: !1, file: !1, line: 20, type: !45, isLocal: false, isDefinition: true, scopeLine: 20, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!45 = !DISubroutineType(types: !46)
!46 = !{!10, !47}
!47 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!48 = !DILocalVariable(name: "X", arg: 1, scope: !44, file: !1, line: 20, type: !47)
!49 = !DILocation(line: 20, column: 19, scope: !44)
!50 = !DILocation(line: 22, column: 19, scope: !44)
!51 = !DILocation(line: 22, column: 21, scope: !44)
!52 = !DILocation(line: 22, column: 10, scope: !44)
!53 = !DILocation(line: 22, column: 3, scope: !44)
!54 = distinct !DISubprogram(name: "testShort", scope: !1, file: !1, line: 25, type: !55, isLocal: false, isDefinition: true, scopeLine: 25, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!55 = !DISubroutineType(types: !56)
!56 = !{!10, !57}
!57 = !DIBasicType(name: "short", size: 16, encoding: DW_ATE_signed)
!58 = !DILocalVariable(name: "X", arg: 1, scope: !54, file: !1, line: 25, type: !57)
!59 = !DILocation(line: 25, column: 21, scope: !54)
!60 = !DILocation(line: 26, column: 17, scope: !54)
!61 = !DILocation(line: 26, column: 3, scope: !54)
!62 = !DILocation(line: 27, column: 19, scope: !54)
!63 = !DILocation(line: 27, column: 21, scope: !54)
!64 = !DILocation(line: 27, column: 10, scope: !54)
!65 = !DILocation(line: 27, column: 3, scope: !54)
!66 = distinct !DISubprogram(name: "testInt", scope: !1, file: !1, line: 30, type: !67, isLocal: false, isDefinition: true, scopeLine: 30, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!67 = !DISubroutineType(types: !68)
!68 = !{!10, !10}
!69 = !DILocalVariable(name: "X", arg: 1, scope: !66, file: !1, line: 30, type: !10)
!70 = !DILocation(line: 30, column: 17, scope: !66)
!71 = !DILocation(line: 32, column: 19, scope: !66)
!72 = !DILocation(line: 32, column: 21, scope: !66)
!73 = !DILocation(line: 32, column: 10, scope: !66)
!74 = !DILocation(line: 32, column: 3, scope: !66)
!75 = distinct !DISubprogram(name: "testLong", scope: !1, file: !1, line: 35, type: !76, isLocal: false, isDefinition: true, scopeLine: 35, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!76 = !DISubroutineType(types: !77)
!77 = !{!10, !78}
!78 = !DIBasicType(name: "long long int", size: 64, encoding: DW_ATE_signed)
!79 = !DILocalVariable(name: "X", arg: 1, scope: !75, file: !1, line: 35, type: !78)
!80 = !DILocation(line: 35, column: 25, scope: !75)
!81 = !DILocation(line: 37, column: 19, scope: !75)
!82 = !DILocation(line: 37, column: 21, scope: !75)
!83 = !DILocation(line: 37, column: 10, scope: !75)
!84 = !DILocation(line: 37, column: 3, scope: !75)
!85 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 40, type: !86, isLocal: false, isDefinition: true, scopeLine: 40, isOptimized: false, unit: !0, variables: !2)
!86 = !DISubroutineType(types: !87)
!87 = !{!10}
!88 = !DILocation(line: 41, column: 10, scope: !85)
!89 = !DILocation(line: 41, column: 22, scope: !85)
!90 = !DILocation(line: 41, column: 3, scope: !85)
!91 = !DILocation(line: 42, column: 10, scope: !85)
!92 = !DILocation(line: 42, column: 24, scope: !85)
!93 = !DILocation(line: 42, column: 3, scope: !85)
!94 = !DILocation(line: 43, column: 10, scope: !85)
!95 = !DILocation(line: 43, column: 23, scope: !85)
!96 = !DILocation(line: 43, column: 3, scope: !85)
!97 = !DILocation(line: 44, column: 10, scope: !85)
!98 = !DILocation(line: 44, column: 26, scope: !85)
!99 = !DILocation(line: 44, column: 3, scope: !85)
!100 = !DILocation(line: 45, column: 10, scope: !85)
!101 = !DILocation(line: 45, column: 21, scope: !85)
!102 = !DILocation(line: 45, column: 3, scope: !85)
!103 = !DILocation(line: 46, column: 10, scope: !85)
!104 = !DILocation(line: 46, column: 24, scope: !85)
!105 = !DILocation(line: 46, column: 3, scope: !85)
!106 = !DILocation(line: 47, column: 10, scope: !85)
!107 = !DILocation(line: 47, column: 22, scope: !85)
!108 = !DILocation(line: 47, column: 3, scope: !85)
!109 = !DILocation(line: 48, column: 10, scope: !85)
!110 = !DILocation(line: 48, column: 38, scope: !85)
!111 = !DILocation(line: 48, column: 3, scope: !85)
!112 = !DILocation(line: 49, column: 10, scope: !85)
!113 = !DILocation(line: 49, column: 41, scope: !85)
!114 = !DILocation(line: 49, column: 3, scope: !85)
!115 = !DILocation(line: 50, column: 10, scope: !85)
!116 = !DILocation(line: 50, column: 30, scope: !85)
!117 = !DILocation(line: 50, column: 3, scope: !85)
!118 = !DILocation(line: 51, column: 3, scope: !85)
!119 = !DILocation(line: 52, column: 3, scope: !85)
