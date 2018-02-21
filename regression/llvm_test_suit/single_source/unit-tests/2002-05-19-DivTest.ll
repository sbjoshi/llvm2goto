; ModuleID = '2002-05-19-DivTest.c'
source_filename = "2002-05-19-DivTest.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define void @testL(i64 %Arg) #0 !dbg !14 {
entry:
  %Arg.addr = alloca i64, align 8
  store i64 %Arg, i64* %Arg.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %Arg.addr, metadata !17, metadata !18), !dbg !19
  %0 = load i64, i64* %Arg.addr, align 8, !dbg !20
  %div = sdiv i64 %0, 16, !dbg !21
  %conv = trunc i64 %div to i32, !dbg !22
  %cmp = icmp eq i32 %conv, 4, !dbg !23
  %conv1 = zext i1 %cmp to i32, !dbg !23
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv1), !dbg !24
  %1 = load i64, i64* %Arg.addr, align 8, !dbg !25
  %div2 = sdiv i64 %1, 70368744177664, !dbg !26
  %conv3 = trunc i64 %div2 to i32, !dbg !27
  %cmp4 = icmp eq i32 %conv3, -127, !dbg !28
  %conv5 = zext i1 %cmp4 to i32, !dbg !28
  %call6 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv5), !dbg !29
  ret void, !dbg !30
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i32 @assert(...) #2

; Function Attrs: noinline nounwind optnone uwtable
define void @test(i32 %Arg) #0 !dbg !31 {
entry:
  %Arg.addr = alloca i32, align 4
  store i32 %Arg, i32* %Arg.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %Arg.addr, metadata !34, metadata !18), !dbg !35
  %0 = load i32, i32* %Arg.addr, align 4, !dbg !36
  %div = sdiv i32 %0, 1, !dbg !37
  %cmp = icmp eq i32 %div, -1048544, !dbg !38
  %conv = zext i1 %cmp to i32, !dbg !38
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !39
  %1 = load i32, i32* %Arg.addr, align 4, !dbg !40
  %div1 = sdiv i32 %1, 16, !dbg !41
  %cmp2 = icmp eq i32 %div1, -65534, !dbg !42
  %conv3 = zext i1 %cmp2 to i32, !dbg !42
  %call4 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv3), !dbg !43
  %2 = load i32, i32* %Arg.addr, align 4, !dbg !44
  %div5 = sdiv i32 %2, 262144, !dbg !45
  %cmp6 = icmp eq i32 %div5, -3, !dbg !46
  %conv7 = zext i1 %cmp6 to i32, !dbg !46
  %call8 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv7), !dbg !47
  %3 = load i32, i32* %Arg.addr, align 4, !dbg !48
  %div9 = sdiv i32 %3, 1073741824, !dbg !49
  %cmp10 = icmp eq i32 %div9, 0, !dbg !50
  %conv11 = zext i1 %cmp10 to i32, !dbg !50
  %call12 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv11), !dbg !51
  ret void, !dbg !52
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !53 {
entry:
  %retval = alloca i32, align 4
  %B20 = alloca i32, align 4
  %B53 = alloca i64, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %B20, metadata !56, metadata !18), !dbg !57
  store i32 -1048576, i32* %B20, align 4, !dbg !57
  call void @llvm.dbg.declare(metadata i64* %B53, metadata !58, metadata !18), !dbg !59
  store i64 -9007199254740992, i64* %B53, align 8, !dbg !59
  %0 = load i32, i32* %B20, align 4, !dbg !60
  %add = add nsw i32 %0, 32, !dbg !61
  call void @test(i32 %add), !dbg !62
  %1 = load i64, i64* %B53, align 8, !dbg !63
  %add1 = add nsw i64 %1, 64, !dbg !64
  call void @testL(i64 %add1), !dbg !65
  ret i32 0, !dbg !66
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!10, !11, !12}
!llvm.ident = !{!13}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3)
!1 = !DIFile(filename: "2002-05-19-DivTest.c", directory: "/home/ubuntu/llvm2goto/regression/llvm_test_suit/single_source/unit-tests")
!2 = !{}
!3 = !{!4, !5}
!4 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!5 = !DIDerivedType(tag: DW_TAG_typedef, name: "int64_t", file: !6, line: 27, baseType: !7)
!6 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/stdint-intn.h", directory: "/home/ubuntu/llvm2goto/regression/llvm_test_suit/single_source/unit-tests")
!7 = !DIDerivedType(tag: DW_TAG_typedef, name: "__int64_t", file: !8, line: 43, baseType: !9)
!8 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types.h", directory: "/home/ubuntu/llvm2goto/regression/llvm_test_suit/single_source/unit-tests")
!9 = !DIBasicType(name: "long int", size: 64, encoding: DW_ATE_signed)
!10 = !{i32 2, !"Dwarf Version", i32 4}
!11 = !{i32 2, !"Debug Info Version", i32 3}
!12 = !{i32 1, !"wchar_size", i32 4}
!13 = !{!"clang version 5.0.1 (tags/RELEASE_501/final)"}
!14 = distinct !DISubprogram(name: "testL", scope: !1, file: !1, line: 9, type: !15, isLocal: false, isDefinition: true, scopeLine: 9, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!15 = !DISubroutineType(types: !16)
!16 = !{null, !5}
!17 = !DILocalVariable(name: "Arg", arg: 1, scope: !14, file: !1, line: 9, type: !5)
!18 = !DIExpression()
!19 = !DILocation(line: 9, column: 20, scope: !14)
!20 = !DILocation(line: 11, column: 17, scope: !14)
!21 = !DILocation(line: 11, column: 21, scope: !14)
!22 = !DILocation(line: 11, column: 10, scope: !14)
!23 = !DILocation(line: 11, column: 42, scope: !14)
!24 = !DILocation(line: 11, column: 3, scope: !14)
!25 = !DILocation(line: 13, column: 17, scope: !14)
!26 = !DILocation(line: 13, column: 21, scope: !14)
!27 = !DILocation(line: 13, column: 10, scope: !14)
!28 = !DILocation(line: 13, column: 43, scope: !14)
!29 = !DILocation(line: 13, column: 3, scope: !14)
!30 = !DILocation(line: 14, column: 1, scope: !14)
!31 = distinct !DISubprogram(name: "test", scope: !1, file: !1, line: 16, type: !32, isLocal: false, isDefinition: true, scopeLine: 16, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!32 = !DISubroutineType(types: !33)
!33 = !{null, !4}
!34 = !DILocalVariable(name: "Arg", arg: 1, scope: !31, file: !1, line: 16, type: !4)
!35 = !DILocation(line: 16, column: 15, scope: !31)
!36 = !DILocation(line: 18, column: 10, scope: !31)
!37 = !DILocation(line: 18, column: 14, scope: !31)
!38 = !DILocation(line: 18, column: 25, scope: !31)
!39 = !DILocation(line: 18, column: 3, scope: !31)
!40 = !DILocation(line: 20, column: 10, scope: !31)
!41 = !DILocation(line: 20, column: 14, scope: !31)
!42 = !DILocation(line: 20, column: 25, scope: !31)
!43 = !DILocation(line: 20, column: 3, scope: !31)
!44 = !DILocation(line: 22, column: 10, scope: !31)
!45 = !DILocation(line: 22, column: 14, scope: !31)
!46 = !DILocation(line: 22, column: 26, scope: !31)
!47 = !DILocation(line: 22, column: 3, scope: !31)
!48 = !DILocation(line: 24, column: 10, scope: !31)
!49 = !DILocation(line: 24, column: 14, scope: !31)
!50 = !DILocation(line: 24, column: 26, scope: !31)
!51 = !DILocation(line: 24, column: 3, scope: !31)
!52 = !DILocation(line: 25, column: 1, scope: !31)
!53 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 27, type: !54, isLocal: false, isDefinition: true, scopeLine: 27, isOptimized: false, unit: !0, variables: !2)
!54 = !DISubroutineType(types: !55)
!55 = !{!4}
!56 = !DILocalVariable(name: "B20", scope: !53, file: !1, line: 28, type: !4)
!57 = !DILocation(line: 28, column: 7, scope: !53)
!58 = !DILocalVariable(name: "B53", scope: !53, file: !1, line: 29, type: !5)
!59 = !DILocation(line: 29, column: 11, scope: !53)
!60 = !DILocation(line: 31, column: 8, scope: !53)
!61 = !DILocation(line: 31, column: 12, scope: !53)
!62 = !DILocation(line: 31, column: 3, scope: !53)
!63 = !DILocation(line: 34, column: 9, scope: !53)
!64 = !DILocation(line: 34, column: 13, scope: !53)
!65 = !DILocation(line: 34, column: 3, scope: !53)
!66 = !DILocation(line: 37, column: 3, scope: !53)
