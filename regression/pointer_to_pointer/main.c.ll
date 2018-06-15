; ModuleID = 'pointer_to_pointer/main.c'
source_filename = "pointer_to_pointer/main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [7 x i8] c"*a1==1\00", align 1
@.str.1 = private unnamed_addr constant [26 x i8] c"pointer_to_pointer/main.c\00", align 1
@__PRETTY_FUNCTION__.main = private unnamed_addr constant [11 x i8] c"int main()\00", align 1
@.str.2 = private unnamed_addr constant [10 x i8] c"**a2 == 3\00", align 1

; Function Attrs: noinline nounwind uwtable
define i32 @main() #0 !dbg !6 {
entry:
  %retval = alloca i32, align 4
  %a = alloca [5 x i32], align 16
  %i = alloca i32, align 4
  %a1 = alloca i32*, align 8
  %a2 = alloca i32**, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata [5 x i32]* %a, metadata !10, metadata !14), !dbg !15
  call void @llvm.dbg.declare(metadata i32* %i, metadata !16, metadata !14), !dbg !18
  store i32 0, i32* %i, align 4, !dbg !18
  br label %for.cond, !dbg !19

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4, !dbg !20
  %cmp = icmp slt i32 %0, 5, !dbg !23
  br i1 %cmp, label %for.body, label %for.end, !dbg !24

for.body:                                         ; preds = %for.cond
  %1 = load i32, i32* %i, align 4, !dbg !26
  %add = add nsw i32 %1, 1, !dbg !28
  %2 = load i32, i32* %i, align 4, !dbg !29
  %idxprom = sext i32 %2 to i64, !dbg !30
  %arrayidx = getelementptr inbounds [5 x i32], [5 x i32]* %a, i64 0, i64 %idxprom, !dbg !30
  store i32 %add, i32* %arrayidx, align 4, !dbg !31
  br label %for.inc, !dbg !32

for.inc:                                          ; preds = %for.body
  %3 = load i32, i32* %i, align 4, !dbg !33
  %inc = add nsw i32 %3, 1, !dbg !33
  store i32 %inc, i32* %i, align 4, !dbg !33
  br label %for.cond, !dbg !35, !llvm.loop !36

for.end:                                          ; preds = %for.cond
  call void @llvm.dbg.declare(metadata i32** %a1, metadata !39, metadata !14), !dbg !41
  call void @llvm.dbg.declare(metadata i32*** %a2, metadata !42, metadata !14), !dbg !44
  %arraydecay = getelementptr inbounds [5 x i32], [5 x i32]* %a, i32 0, i32 0, !dbg !45
  store i32* %arraydecay, i32** %a1, align 8, !dbg !46
  store i32** %a1, i32*** %a2, align 8, !dbg !47
  %4 = load i32*, i32** %a1, align 8, !dbg !48
  %5 = load i32, i32* %4, align 4, !dbg !48
  %cmp1 = icmp eq i32 %5, 1, !dbg !48
  br i1 %cmp1, label %cond.true, label %cond.false, !dbg !48

cond.true:                                        ; preds = %for.end
  br label %cond.end, !dbg !49

cond.false:                                       ; preds = %for.end
  call void @__assert_fail(i8* getelementptr inbounds ([7 x i8], [7 x i8]* @.str, i32 0, i32 0), i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.1, i32 0, i32 0), i32 19, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @__PRETTY_FUNCTION__.main, i32 0, i32 0)) #3, !dbg !51
  unreachable, !dbg !51
                                                  ; No predecessors!
  br label %cond.end, !dbg !53

cond.end:                                         ; preds = %6, %cond.true
  %7 = load i32*, i32** %a1, align 8, !dbg !55
  %incdec.ptr = getelementptr inbounds i32, i32* %7, i32 1, !dbg !55
  store i32* %incdec.ptr, i32** %a1, align 8, !dbg !55
  %8 = load i32*, i32** %a1, align 8, !dbg !56
  %incdec.ptr2 = getelementptr inbounds i32, i32* %8, i32 1, !dbg !56
  store i32* %incdec.ptr2, i32** %a1, align 8, !dbg !56
  %9 = load i32**, i32*** %a2, align 8, !dbg !57
  %10 = load i32*, i32** %9, align 8, !dbg !57
  %11 = load i32, i32* %10, align 4, !dbg !57
  %cmp3 = icmp eq i32 %11, 3, !dbg !57
  br i1 %cmp3, label %cond.true4, label %cond.false5, !dbg !57

cond.true4:                                       ; preds = %cond.end
  br label %cond.end6, !dbg !58

cond.false5:                                      ; preds = %cond.end
  call void @__assert_fail(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.2, i32 0, i32 0), i8* getelementptr inbounds ([26 x i8], [26 x i8]* @.str.1, i32 0, i32 0), i32 24, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @__PRETTY_FUNCTION__.main, i32 0, i32 0)) #3, !dbg !59
  unreachable, !dbg !59
                                                  ; No predecessors!
  br label %cond.end6, !dbg !60

cond.end6:                                        ; preds = %12, %cond.true4
  ret i32 0, !dbg !61
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noreturn nounwind
declare void @__assert_fail(i8*, i8*, i32, i8*) #2

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { noreturn nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { noreturn nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4}
!llvm.ident = !{!5}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.0 (trunk 295264)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "pointer_to_pointer/main.c", directory: "/home/rasika/llvm2goto/llvm2goto-regression-master")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{!"clang version 5.0.0 (trunk 295264)"}
!6 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 3, type: !7, isLocal: false, isDefinition: true, scopeLine: 4, isOptimized: false, unit: !0, variables: !2)
!7 = !DISubroutineType(types: !8)
!8 = !{!9}
!9 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!10 = !DILocalVariable(name: "a", scope: !6, file: !1, line: 5, type: !11)
!11 = !DICompositeType(tag: DW_TAG_array_type, baseType: !9, size: 160, elements: !12)
!12 = !{!13}
!13 = !DISubrange(count: 5)
!14 = !DIExpression()
!15 = !DILocation(line: 5, column: 6, scope: !6)
!16 = !DILocalVariable(name: "i", scope: !17, file: !1, line: 8, type: !9)
!17 = distinct !DILexicalBlock(scope: !6, file: !1, line: 8, column: 2)
!18 = !DILocation(line: 8, column: 10, scope: !17)
!19 = !DILocation(line: 8, column: 6, scope: !17)
!20 = !DILocation(line: 8, column: 16, scope: !21)
!21 = !DILexicalBlockFile(scope: !22, file: !1, discriminator: 2)
!22 = distinct !DILexicalBlock(scope: !17, file: !1, line: 8, column: 2)
!23 = !DILocation(line: 8, column: 17, scope: !21)
!24 = !DILocation(line: 8, column: 2, scope: !25)
!25 = !DILexicalBlockFile(scope: !17, file: !1, discriminator: 2)
!26 = !DILocation(line: 10, column: 10, scope: !27)
!27 = distinct !DILexicalBlock(scope: !22, file: !1, line: 9, column: 2)
!28 = !DILocation(line: 10, column: 11, scope: !27)
!29 = !DILocation(line: 10, column: 5, scope: !27)
!30 = !DILocation(line: 10, column: 3, scope: !27)
!31 = !DILocation(line: 10, column: 8, scope: !27)
!32 = !DILocation(line: 11, column: 2, scope: !27)
!33 = !DILocation(line: 8, column: 23, scope: !34)
!34 = !DILexicalBlockFile(scope: !22, file: !1, discriminator: 4)
!35 = !DILocation(line: 8, column: 2, scope: !34)
!36 = distinct !{!36, !37, !38}
!37 = !DILocation(line: 8, column: 2, scope: !17)
!38 = !DILocation(line: 11, column: 2, scope: !17)
!39 = !DILocalVariable(name: "a1", scope: !6, file: !1, line: 13, type: !40)
!40 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !9, size: 64)
!41 = !DILocation(line: 13, column: 7, scope: !6)
!42 = !DILocalVariable(name: "a2", scope: !6, file: !1, line: 14, type: !43)
!43 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !40, size: 64)
!44 = !DILocation(line: 14, column: 8, scope: !6)
!45 = !DILocation(line: 16, column: 7, scope: !6)
!46 = !DILocation(line: 16, column: 5, scope: !6)
!47 = !DILocation(line: 17, column: 5, scope: !6)
!48 = !DILocation(line: 19, column: 2, scope: !6)
!49 = !DILocation(line: 19, column: 2, scope: !50)
!50 = !DILexicalBlockFile(scope: !6, file: !1, discriminator: 2)
!51 = !DILocation(line: 19, column: 2, scope: !52)
!52 = !DILexicalBlockFile(scope: !6, file: !1, discriminator: 4)
!53 = !DILocation(line: 19, column: 2, scope: !54)
!54 = !DILexicalBlockFile(scope: !6, file: !1, discriminator: 6)
!55 = !DILocation(line: 21, column: 4, scope: !6)
!56 = !DILocation(line: 22, column: 4, scope: !6)
!57 = !DILocation(line: 24, column: 2, scope: !6)
!58 = !DILocation(line: 24, column: 2, scope: !50)
!59 = !DILocation(line: 24, column: 2, scope: !52)
!60 = !DILocation(line: 24, column: 2, scope: !54)
!61 = !DILocation(line: 26, column: 2, scope: !6)
