; ModuleID = '2002-05-02-CastTest3.c'
source_filename = "2002-05-02-CastTest3.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !9 {
entry:
  %retval = alloca i32, align 4
  %i = alloca i32, align 4
  %s1 = alloca i16, align 2
  %us2 = alloca i16, align 2
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %i, metadata !13, metadata !14), !dbg !15
  %0 = load i32, i32* %i, align 4, !dbg !16
  %cmp = icmp slt i32 %0, 3, !dbg !17
  %conv = zext i1 %cmp to i32, !dbg !17
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assume to i32 (i32, ...)*)(i32 %conv), !dbg !18
  call void @llvm.dbg.declare(metadata i16* %s1, metadata !19, metadata !14), !dbg !21
  %1 = load i32, i32* %i, align 4, !dbg !22
  %cmp1 = icmp sge i32 %1, 3, !dbg !23
  br i1 %cmp1, label %cond.true, label %cond.false, !dbg !24

cond.true:                                        ; preds = %entry
  %2 = load i32, i32* %i, align 4, !dbg !25
  br label %cond.end, !dbg !24

cond.false:                                       ; preds = %entry
  br label %cond.end, !dbg !24

cond.end:                                         ; preds = %cond.false, %cond.true
  %cond = phi i32 [ %2, %cond.true ], [ -769, %cond.false ], !dbg !24
  %conv3 = trunc i32 %cond to i16, !dbg !24
  store i16 %conv3, i16* %s1, align 2, !dbg !21
  call void @llvm.dbg.declare(metadata i16* %us2, metadata !26, metadata !14), !dbg !27
  %3 = load i16, i16* %s1, align 2, !dbg !28
  store i16 %3, i16* %us2, align 2, !dbg !27
  %4 = load i16, i16* %s1, align 2, !dbg !29
  %conv4 = sext i16 %4 to i32, !dbg !29
  %cmp5 = icmp eq i32 %conv4, -769, !dbg !30
  %conv6 = zext i1 %cmp5 to i32, !dbg !30
  %call7 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv6), !dbg !31
  %5 = load i16, i16* %us2, align 2, !dbg !32
  %conv8 = zext i16 %5 to i32, !dbg !32
  %cmp9 = icmp eq i32 %conv8, 64767, !dbg !33
  %conv10 = zext i1 %cmp9 to i32, !dbg !33
  %call11 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv10), !dbg !34
  ret i32 0, !dbg !35
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i32 @assume(...) #2

declare i32 @assert(...) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!5, !6, !7}
!llvm.ident = !{!8}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3)
!1 = !DIFile(filename: "2002-05-02-CastTest3.c", directory: "/home/ubuntu/llvm2goto/regression/llvm_test_suit/single_source/unit-tests")
!2 = !{}
!3 = !{!4}
!4 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!5 = !{i32 2, !"Dwarf Version", i32 4}
!6 = !{i32 2, !"Debug Info Version", i32 3}
!7 = !{i32 1, !"wchar_size", i32 4}
!8 = !{!"clang version 5.0.1 (tags/RELEASE_501/final)"}
!9 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 3, type: !10, isLocal: false, isDefinition: true, scopeLine: 3, isOptimized: false, unit: !0, variables: !2)
!10 = !DISubroutineType(types: !11)
!11 = !{!12}
!12 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!13 = !DILocalVariable(name: "i", scope: !9, file: !1, line: 4, type: !12)
!14 = !DIExpression()
!15 = !DILocation(line: 4, column: 7, scope: !9)
!16 = !DILocation(line: 5, column: 10, scope: !9)
!17 = !DILocation(line: 5, column: 12, scope: !9)
!18 = !DILocation(line: 5, column: 3, scope: !9)
!19 = !DILocalVariable(name: "s1", scope: !9, file: !1, line: 6, type: !20)
!20 = !DIBasicType(name: "short", size: 16, encoding: DW_ATE_signed)
!21 = !DILocation(line: 6, column: 9, scope: !9)
!22 = !DILocation(line: 6, column: 15, scope: !9)
!23 = !DILocation(line: 6, column: 17, scope: !9)
!24 = !DILocation(line: 6, column: 14, scope: !9)
!25 = !DILocation(line: 6, column: 24, scope: !9)
!26 = !DILocalVariable(name: "us2", scope: !9, file: !1, line: 8, type: !4)
!27 = !DILocation(line: 8, column: 18, scope: !9)
!28 = !DILocation(line: 8, column: 41, scope: !9)
!29 = !DILocation(line: 10, column: 10, scope: !9)
!30 = !DILocation(line: 10, column: 13, scope: !9)
!31 = !DILocation(line: 10, column: 3, scope: !9)
!32 = !DILocation(line: 11, column: 10, scope: !9)
!33 = !DILocation(line: 11, column: 14, scope: !9)
!34 = !DILocation(line: 11, column: 3, scope: !9)
!35 = !DILocation(line: 12, column: 3, scope: !9)
