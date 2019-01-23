; ModuleID = 'pointer_to_pointer/main.c'
source_filename = "pointer_to_pointer/main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [7 x i8] c"*a1==1\00", align 1
@.str.1 = private unnamed_addr constant [26 x i8] c"pointer_to_pointer/main.c\00", align 1
@__PRETTY_FUNCTION__.main = private unnamed_addr constant [11 x i8] c"int main()\00", align 1
@.str.2 = private unnamed_addr constant [10 x i8] c"**a2 == 3\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !7 {
entry:
  %retval = alloca i32, align 4
  %a = alloca [5 x i32], align 16
  %i = alloca i32, align 4
  %a1 = alloca i32*, align 8
  %a2 = alloca i32**, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata [5 x i32]* %a, metadata !11, metadata !DIExpression()), !dbg !15
  call void @llvm.dbg.declare(metadata i32* %i, metadata !16, metadata !DIExpression()), !dbg !18
  store i32 0, i32* %i, align 4, !dbg !18
  br label %for.cond, !dbg !19

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4, !dbg !20
  %cmp = icmp slt i32 %0, 5, !dbg !22
  br i1 %cmp, label %for.body, label %for.end, !dbg !23

for.body:                                         ; preds = %for.cond
  %1 = load i32, i32* %i, align 4, !dbg !24
  %add = add nsw i32 %1, 1, !dbg !26
  %2 = load i32, i32* %i, align 4, !dbg !27
  %idxprom = sext i32 %2 to i64, !dbg !28
  %arrayidx = getelementptr inbounds [5 x i32], [5 x i32]* %a, i64 0, i64 %idxprom, !dbg !28
  store i32 %add, i32* %arrayidx, align 4, !dbg !29
  br label %for.inc, !dbg !30

for.inc:                                          ; preds = %for.body
  %3 = load i32, i32* %i, align 4, !dbg !31
  %inc = add nsw i32 %3, 1, !dbg !31
  store i32 %inc, i32* %i, align 4, !dbg !31
  br label %for.cond, !dbg !32, !llvm.loop !33

for.end:                                          ; preds = %for.cond
  call void @llvm.dbg.declare(metadata i32** %a1, metadata !35, metadata !DIExpression()), !dbg !37
  call void @llvm.dbg.declare(metadata i32*** %a2, metadata !38, metadata !DIExpression()), !dbg !40
  %arraydecay = getelementptr inbounds [5 x i32], [5 x i32]* %a, i32 0, i32 0, !dbg !41
  store i32* %arraydecay, i32** %a1, align 8, !dbg !42
  store i32** %a1, i32*** %a2, align 8, !dbg !43
  %4 = load i32*, i32** %a1, align 8, !dbg !44
  %5 = load i32, i32* %4, align 4, !dbg !44
  %cmp1 = icmp eq i32 %5, 1, !dbg !44
  br i1 %cmp1, label %if.then, label %if.else, !dbg !47

if.then:                                          ; preds = %for.end
  br label %if.end, !dbg !47

if.else:                                          ; preds = %for.end
  call void @__assert_fail(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str, i32 0, i32 0), i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.1, i32 0, i32 0), i32 19, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @__PRETTY_FUNCTION__.main, i32 0, i32 0)) #3, !dbg !44
  unreachable, !dbg !44

if.end:                                           ; preds = %if.then
  %6 = load i32*, i32** %a1, align 8, !dbg !48
  %incdec.ptr = getelementptr inbounds i32, i32* %6, i32 1, !dbg !48
  store i32* %incdec.ptr, i32** %a1, align 8, !dbg !48
  %7 = load i32*, i32** %a1, align 8, !dbg !49
  %incdec.ptr2 = getelementptr inbounds i32, i32* %7, i32 1, !dbg !49
  store i32* %incdec.ptr2, i32** %a1, align 8, !dbg !49
  %8 = load i32**, i32*** %a2, align 8, !dbg !50
  %9 = load i32*, i32** %8, align 8, !dbg !50
  %10 = load i32, i32* %9, align 4, !dbg !50
  %cmp3 = icmp eq i32 %10, 3, !dbg !50
  br i1 %cmp3, label %if.then4, label %if.else5, !dbg !53

if.then4:                                         ; preds = %if.end
  br label %if.end6, !dbg !53

if.else5:                                         ; preds = %if.end
  call void @__assert_fail(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.2, i32 0, i32 0), i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.1, i32 0, i32 0), i32 24, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @__PRETTY_FUNCTION__.main, i32 0, i32 0)) #3, !dbg !50
  unreachable, !dbg !50

if.end6:                                          ; preds = %if.then4
  ret i32 0, !dbg !54
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noreturn nounwind
declare dso_local void @__assert_fail(i8*, i8*, i32, i8*) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { noreturn nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { noreturn nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 7.0.1 (https://github.com/llvm-mirror/clang.git 4519e2637fcc4bf6e3049a0a80e6a5e7b97667cb) (https://github.com/llvm-mirror/llvm.git cd98f42d0747826062fc3d2d2fad383aedf58dd6)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "pointer_to_pointer/main.c", directory: "/home/akash/Documents/CBMC/cbmc/src/llvm2goto/regression")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 7.0.1 (https://github.com/llvm-mirror/clang.git 4519e2637fcc4bf6e3049a0a80e6a5e7b97667cb) (https://github.com/llvm-mirror/llvm.git cd98f42d0747826062fc3d2d2fad383aedf58dd6)"}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 3, type: !8, isLocal: false, isDefinition: true, scopeLine: 4, isOptimized: false, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "a", scope: !7, file: !1, line: 5, type: !12)
!12 = !DICompositeType(tag: DW_TAG_array_type, baseType: !10, size: 160, elements: !13)
!13 = !{!14}
!14 = !DISubrange(count: 5)
!15 = !DILocation(line: 5, column: 6, scope: !7)
!16 = !DILocalVariable(name: "i", scope: !17, file: !1, line: 8, type: !10)
!17 = distinct !DILexicalBlock(scope: !7, file: !1, line: 8, column: 2)
!18 = !DILocation(line: 8, column: 10, scope: !17)
!19 = !DILocation(line: 8, column: 6, scope: !17)
!20 = !DILocation(line: 8, column: 16, scope: !21)
!21 = distinct !DILexicalBlock(scope: !17, file: !1, line: 8, column: 2)
!22 = !DILocation(line: 8, column: 17, scope: !21)
!23 = !DILocation(line: 8, column: 2, scope: !17)
!24 = !DILocation(line: 10, column: 10, scope: !25)
!25 = distinct !DILexicalBlock(scope: !21, file: !1, line: 9, column: 2)
!26 = !DILocation(line: 10, column: 11, scope: !25)
!27 = !DILocation(line: 10, column: 5, scope: !25)
!28 = !DILocation(line: 10, column: 3, scope: !25)
!29 = !DILocation(line: 10, column: 8, scope: !25)
!30 = !DILocation(line: 11, column: 2, scope: !25)
!31 = !DILocation(line: 8, column: 23, scope: !21)
!32 = !DILocation(line: 8, column: 2, scope: !21)
!33 = distinct !{!33, !23, !34}
!34 = !DILocation(line: 11, column: 2, scope: !17)
!35 = !DILocalVariable(name: "a1", scope: !7, file: !1, line: 13, type: !36)
!36 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !10, size: 64)
!37 = !DILocation(line: 13, column: 7, scope: !7)
!38 = !DILocalVariable(name: "a2", scope: !7, file: !1, line: 14, type: !39)
!39 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !36, size: 64)
!40 = !DILocation(line: 14, column: 8, scope: !7)
!41 = !DILocation(line: 16, column: 7, scope: !7)
!42 = !DILocation(line: 16, column: 5, scope: !7)
!43 = !DILocation(line: 17, column: 5, scope: !7)
!44 = !DILocation(line: 19, column: 2, scope: !45)
!45 = distinct !DILexicalBlock(scope: !46, file: !1, line: 19, column: 2)
!46 = distinct !DILexicalBlock(scope: !7, file: !1, line: 19, column: 2)
!47 = !DILocation(line: 19, column: 2, scope: !46)
!48 = !DILocation(line: 21, column: 4, scope: !7)
!49 = !DILocation(line: 22, column: 4, scope: !7)
!50 = !DILocation(line: 24, column: 2, scope: !51)
!51 = distinct !DILexicalBlock(scope: !52, file: !1, line: 24, column: 2)
!52 = distinct !DILexicalBlock(scope: !7, file: !1, line: 24, column: 2)
!53 = !DILocation(line: 24, column: 2, scope: !52)
!54 = !DILocation(line: 26, column: 2, scope: !7)
