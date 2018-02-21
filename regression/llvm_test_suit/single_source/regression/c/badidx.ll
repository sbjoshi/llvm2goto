; ModuleID = 'badidx.c'
source_filename = "badidx.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main(i32 %argc, i8** %argv) #0 !dbg !10 {
entry:
  %retval = alloca i32, align 4
  %argc.addr = alloca i32, align 4
  %argv.addr = alloca i8**, align 8
  %i = alloca i32, align 4
  %n = alloca i32, align 4
  %y = alloca i32*, align 8
  store i32 0, i32* %retval, align 4
  store i32 %argc, i32* %argc.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %argc.addr, metadata !16, metadata !17), !dbg !18
  store i8** %argv, i8*** %argv.addr, align 8
  call void @llvm.dbg.declare(metadata i8*** %argv.addr, metadata !19, metadata !17), !dbg !20
  call void @llvm.dbg.declare(metadata i32* %i, metadata !21, metadata !17), !dbg !22
  call void @llvm.dbg.declare(metadata i32* %n, metadata !23, metadata !17), !dbg !24
  %0 = load i32, i32* %argc.addr, align 4, !dbg !25
  %cmp = icmp eq i32 %0, 2, !dbg !26
  br i1 %cmp, label %cond.true, label %cond.false, !dbg !27

cond.true:                                        ; preds = %entry
  %1 = load i8**, i8*** %argv.addr, align 8, !dbg !28
  %arrayidx = getelementptr inbounds i8*, i8** %1, i64 1, !dbg !28
  %2 = load i8*, i8** %arrayidx, align 8, !dbg !28
  %call = call i32 @atoi(i8* %2) #5, !dbg !29
  br label %cond.end, !dbg !27

cond.false:                                       ; preds = %entry
  br label %cond.end, !dbg !27

cond.end:                                         ; preds = %cond.false, %cond.true
  %cond = phi i32 [ %call, %cond.true ], [ 1, %cond.false ], !dbg !27
  store i32 %cond, i32* %n, align 4, !dbg !24
  call void @llvm.dbg.declare(metadata i32** %y, metadata !30, metadata !17), !dbg !31
  %3 = load i32, i32* %n, align 4, !dbg !32
  %conv = sext i32 %3 to i64, !dbg !32
  %call1 = call noalias i8* @calloc(i64 %conv, i64 4) #6, !dbg !33
  %4 = bitcast i8* %call1 to i32*, !dbg !34
  store i32* %4, i32** %y, align 8, !dbg !31
  store i32 0, i32* %i, align 4, !dbg !35
  br label %for.cond, !dbg !37

for.cond:                                         ; preds = %for.inc, %cond.end
  %5 = load i32, i32* %i, align 4, !dbg !38
  %6 = load i32, i32* %n, align 4, !dbg !40
  %cmp2 = icmp slt i32 %5, %6, !dbg !41
  br i1 %cmp2, label %for.body, label %for.end, !dbg !42

for.body:                                         ; preds = %for.cond
  %7 = load i32, i32* %i, align 4, !dbg !43
  %8 = load i32, i32* %i, align 4, !dbg !44
  %mul = mul nsw i32 %7, %8, !dbg !45
  %9 = load i32*, i32** %y, align 8, !dbg !46
  %10 = load i32, i32* %i, align 4, !dbg !47
  %idxprom = sext i32 %10 to i64, !dbg !46
  %arrayidx4 = getelementptr inbounds i32, i32* %9, i64 %idxprom, !dbg !46
  store i32 %mul, i32* %arrayidx4, align 4, !dbg !48
  br label %for.inc, !dbg !46

for.inc:                                          ; preds = %for.body
  %11 = load i32, i32* %i, align 4, !dbg !49
  %inc = add nsw i32 %11, 1, !dbg !49
  store i32 %inc, i32* %i, align 4, !dbg !49
  br label %for.cond, !dbg !50, !llvm.loop !51

for.end:                                          ; preds = %for.cond
  %12 = load i32*, i32** %y, align 8, !dbg !53
  %13 = load i32, i32* %n, align 4, !dbg !54
  %sub = sub nsw i32 %13, 1, !dbg !55
  %idxprom5 = sext i32 %sub to i64, !dbg !53
  %arrayidx6 = getelementptr inbounds i32, i32* %12, i64 %idxprom5, !dbg !53
  %14 = load i32, i32* %arrayidx6, align 4, !dbg !53
  %call7 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str, i32 0, i32 0), i32 %14), !dbg !56
  ret i32 0, !dbg !57
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nounwind readonly
declare i32 @atoi(i8*) #2

; Function Attrs: nounwind
declare noalias i8* @calloc(i64, i64) #3

declare i32 @printf(i8*, ...) #4

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { nounwind readonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nounwind readonly }
attributes #6 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!6, !7, !8}
!llvm.ident = !{!9}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3)
!1 = !DIFile(filename: "badidx.c", directory: "/home/ubuntu/llvm2goto/regression/llvm_test_suit/single_source/regression/c")
!2 = !{}
!3 = !{!4}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !5, size: 64)
!5 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!6 = !{i32 2, !"Dwarf Version", i32 4}
!7 = !{i32 2, !"Debug Info Version", i32 3}
!8 = !{i32 1, !"wchar_size", i32 4}
!9 = !{!"clang version 5.0.1 (tags/RELEASE_501/final)"}
!10 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 18, type: !11, isLocal: false, isDefinition: true, scopeLine: 18, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!11 = !DISubroutineType(types: !12)
!12 = !{!5, !5, !13}
!13 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !14, size: 64)
!14 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !15, size: 64)
!15 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!16 = !DILocalVariable(name: "argc", arg: 1, scope: !10, file: !1, line: 18, type: !5)
!17 = !DIExpression()
!18 = !DILocation(line: 18, column: 10, scope: !10)
!19 = !DILocalVariable(name: "argv", arg: 2, scope: !10, file: !1, line: 18, type: !13)
!20 = !DILocation(line: 18, column: 22, scope: !10)
!21 = !DILocalVariable(name: "i", scope: !10, file: !1, line: 19, type: !5)
!22 = !DILocation(line: 19, column: 9, scope: !10)
!23 = !DILocalVariable(name: "n", scope: !10, file: !1, line: 19, type: !5)
!24 = !DILocation(line: 19, column: 12, scope: !10)
!25 = !DILocation(line: 19, column: 18, scope: !10)
!26 = !DILocation(line: 19, column: 23, scope: !10)
!27 = !DILocation(line: 19, column: 17, scope: !10)
!28 = !DILocation(line: 19, column: 36, scope: !10)
!29 = !DILocation(line: 19, column: 31, scope: !10)
!30 = !DILocalVariable(name: "y", scope: !10, file: !1, line: 20, type: !4)
!31 = !DILocation(line: 20, column: 10, scope: !10)
!32 = !DILocation(line: 20, column: 29, scope: !10)
!33 = !DILocation(line: 20, column: 22, scope: !10)
!34 = !DILocation(line: 20, column: 14, scope: !10)
!35 = !DILocation(line: 21, column: 11, scope: !36)
!36 = distinct !DILexicalBlock(scope: !10, file: !1, line: 21, column: 5)
!37 = !DILocation(line: 21, column: 10, scope: !36)
!38 = !DILocation(line: 21, column: 15, scope: !39)
!39 = distinct !DILexicalBlock(scope: !36, file: !1, line: 21, column: 5)
!40 = !DILocation(line: 21, column: 19, scope: !39)
!41 = !DILocation(line: 21, column: 17, scope: !39)
!42 = !DILocation(line: 21, column: 5, scope: !36)
!43 = !DILocation(line: 22, column: 14, scope: !39)
!44 = !DILocation(line: 22, column: 16, scope: !39)
!45 = !DILocation(line: 22, column: 15, scope: !39)
!46 = !DILocation(line: 22, column: 7, scope: !39)
!47 = !DILocation(line: 22, column: 9, scope: !39)
!48 = !DILocation(line: 22, column: 12, scope: !39)
!49 = !DILocation(line: 21, column: 23, scope: !39)
!50 = !DILocation(line: 21, column: 5, scope: !39)
!51 = distinct !{!51, !42, !52}
!52 = !DILocation(line: 22, column: 16, scope: !36)
!53 = !DILocation(line: 23, column: 20, scope: !10)
!54 = !DILocation(line: 23, column: 22, scope: !10)
!55 = !DILocation(line: 23, column: 23, scope: !10)
!56 = !DILocation(line: 23, column: 5, scope: !10)
!57 = !DILocation(line: 24, column: 5, scope: !10)
