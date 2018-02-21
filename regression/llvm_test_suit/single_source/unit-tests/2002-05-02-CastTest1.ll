; ModuleID = '2002-05-02-CastTest1.c'
source_filename = "2002-05-02-CastTest1.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !7 {
entry:
  %retval = alloca i32, align 4
  %c0 = alloca i8, align 1
  %c1 = alloca i8, align 1
  %i = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i8* %c0, metadata !11, metadata !13), !dbg !14
  store i8 -1, i8* %c0, align 1, !dbg !14
  call void @llvm.dbg.declare(metadata i8* %c1, metadata !15, metadata !13), !dbg !17
  store i8 -1, i8* %c1, align 1, !dbg !17
  call void @llvm.dbg.declare(metadata i32* %i, metadata !18, metadata !13), !dbg !19
  %0 = load i8, i8* %c0, align 1, !dbg !20
  %conv = sext i8 %0 to i32, !dbg !20
  store i32 %conv, i32* %i, align 4, !dbg !19
  %1 = load i32, i32* %i, align 4, !dbg !21
  %cmp = icmp eq i32 %1, -1, !dbg !22
  %conv1 = zext i1 %cmp to i32, !dbg !22
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv1), !dbg !23
  %2 = load i8, i8* %c1, align 1, !dbg !24
  %conv2 = zext i8 %2 to i32, !dbg !24
  store i32 %conv2, i32* %i, align 4, !dbg !25
  %3 = load i32, i32* %i, align 4, !dbg !26
  %cmp3 = icmp eq i32 %3, 255, !dbg !27
  %conv4 = zext i1 %cmp3 to i32, !dbg !27
  %call5 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv4), !dbg !28
  ret i32 0, !dbg !29
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i32 @assert(...) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "2002-05-02-CastTest1.c", directory: "/home/ubuntu/llvm2goto/regression/llvm_test_suit/single_source/unit-tests")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final)"}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 3, type: !8, isLocal: false, isDefinition: true, scopeLine: 4, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "c0", scope: !7, file: !1, line: 5, type: !12)
!12 = !DIBasicType(name: "signed char", size: 8, encoding: DW_ATE_signed_char)
!13 = !DIExpression()
!14 = !DILocation(line: 5, column: 15, scope: !7)
!15 = !DILocalVariable(name: "c1", scope: !7, file: !1, line: 6, type: !16)
!16 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!17 = !DILocation(line: 6, column: 17, scope: !7)
!18 = !DILocalVariable(name: "i", scope: !7, file: !1, line: 7, type: !10)
!19 = !DILocation(line: 7, column: 7, scope: !7)
!20 = !DILocation(line: 7, column: 11, scope: !7)
!21 = !DILocation(line: 8, column: 10, scope: !7)
!22 = !DILocation(line: 8, column: 12, scope: !7)
!23 = !DILocation(line: 8, column: 3, scope: !7)
!24 = !DILocation(line: 9, column: 7, scope: !7)
!25 = !DILocation(line: 9, column: 5, scope: !7)
!26 = !DILocation(line: 10, column: 10, scope: !7)
!27 = !DILocation(line: 10, column: 12, scope: !7)
!28 = !DILocation(line: 10, column: 3, scope: !7)
!29 = !DILocation(line: 11, column: 3, scope: !7)
