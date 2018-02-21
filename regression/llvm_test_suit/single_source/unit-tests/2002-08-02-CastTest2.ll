; ModuleID = '2002-08-02-CastTest2.c'
source_filename = "2002-08-02-CastTest2.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define void @test(i16 signext %s1) #0 !dbg !9 {
entry:
  %s1.addr = alloca i16, align 2
  %us2 = alloca i16, align 2
  store i16 %s1, i16* %s1.addr, align 2
  call void @llvm.dbg.declare(metadata i16* %s1.addr, metadata !13, metadata !14), !dbg !15
  call void @llvm.dbg.declare(metadata i16* %us2, metadata !16, metadata !14), !dbg !17
  %0 = load i16, i16* %s1.addr, align 2, !dbg !18
  store i16 %0, i16* %us2, align 2, !dbg !17
  %1 = load i16, i16* %s1.addr, align 2, !dbg !19
  %conv = sext i16 %1 to i32, !dbg !19
  %cmp = icmp eq i32 %conv, -769, !dbg !20
  %conv1 = zext i1 %cmp to i32, !dbg !20
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv1), !dbg !21
  %2 = load i16, i16* %us2, align 2, !dbg !22
  %conv2 = zext i16 %2 to i32, !dbg !22
  %cmp3 = icmp eq i32 %conv2, 64767, !dbg !23
  %conv4 = zext i1 %cmp3 to i32, !dbg !23
  %call5 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv4), !dbg !24
  ret void, !dbg !25
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i32 @assert(...) #2

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !26 {
entry:
  %retval = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @test(i16 signext -769), !dbg !30
  ret i32 0, !dbg !31
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!5, !6, !7}
!llvm.ident = !{!8}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3)
!1 = !DIFile(filename: "2002-08-02-CastTest2.c", directory: "/home/ubuntu/llvm2goto/regression/llvm_test_suit/single_source/unit-tests")
!2 = !{}
!3 = !{!4}
!4 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!5 = !{i32 2, !"Dwarf Version", i32 4}
!6 = !{i32 2, !"Debug Info Version", i32 3}
!7 = !{i32 1, !"wchar_size", i32 4}
!8 = !{!"clang version 5.0.1 (tags/RELEASE_501/final)"}
!9 = distinct !DISubprogram(name: "test", scope: !1, file: !1, line: 3, type: !10, isLocal: false, isDefinition: true, scopeLine: 3, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!10 = !DISubroutineType(types: !11)
!11 = !{null, !12}
!12 = !DIBasicType(name: "short", size: 16, encoding: DW_ATE_signed)
!13 = !DILocalVariable(name: "s1", arg: 1, scope: !9, file: !1, line: 3, type: !12)
!14 = !DIExpression()
!15 = !DILocation(line: 3, column: 17, scope: !9)
!16 = !DILocalVariable(name: "us2", scope: !9, file: !1, line: 4, type: !4)
!17 = !DILocation(line: 4, column: 18, scope: !9)
!18 = !DILocation(line: 4, column: 41, scope: !9)
!19 = !DILocation(line: 8, column: 9, scope: !9)
!20 = !DILocation(line: 8, column: 12, scope: !9)
!21 = !DILocation(line: 8, column: 2, scope: !9)
!22 = !DILocation(line: 9, column: 9, scope: !9)
!23 = !DILocation(line: 9, column: 13, scope: !9)
!24 = !DILocation(line: 9, column: 2, scope: !9)
!25 = !DILocation(line: 10, column: 1, scope: !9)
!26 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 12, type: !27, isLocal: false, isDefinition: true, scopeLine: 12, isOptimized: false, unit: !0, variables: !2)
!27 = !DISubroutineType(types: !28)
!28 = !{!29}
!29 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!30 = !DILocation(line: 13, column: 3, scope: !26)
!31 = !DILocation(line: 14, column: 3, scope: !26)
