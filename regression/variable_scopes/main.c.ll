; ModuleID = 'variable_scopes/main.c'
source_filename = "variable_scopes/main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@glob = global i32 10, align 4, !dbg !0
@.str = private unnamed_addr constant [6 x i8] c"x==10\00", align 1
@.str.1 = private unnamed_addr constant [23 x i8] c"variable_scopes/main.c\00", align 1
@__PRETTY_FUNCTION__.main = private unnamed_addr constant [11 x i8] c"int main()\00", align 1
@.str.2 = private unnamed_addr constant [5 x i8] c"x==5\00", align 1
@.str.3 = private unnamed_addr constant [9 x i8] c"glob ==5\00", align 1
@.str.4 = private unnamed_addr constant [10 x i8] c"x+y == 15\00", align 1

; Function Attrs: noinline nounwind uwtable
define i32 @main() #0 !dbg !10 {
entry:
  %retval = alloca i32, align 4
  %x = alloca i32, align 4
  %x1 = alloca i32, align 4
  %glob = alloca i32, align 4
  %y = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %x, metadata !13, metadata !14), !dbg !15
  store i32 5, i32* %x, align 4, !dbg !15
  call void @llvm.dbg.declare(metadata i32* %x1, metadata !16, metadata !14), !dbg !18
  store i32 10, i32* %x1, align 4, !dbg !18
  %0 = load i32, i32* %x1, align 4, !dbg !19
  %cmp = icmp eq i32 %0, 10, !dbg !19
  br i1 %cmp, label %cond.true, label %cond.false, !dbg !19

cond.true:                                        ; preds = %entry
  br label %cond.end, !dbg !20

cond.false:                                       ; preds = %entry
  call void @__assert_fail(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str, i32 0, i32 0), i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.1, i32 0, i32 0), i32 11, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @__PRETTY_FUNCTION__.main, i32 0, i32 0)) #3, !dbg !22
  unreachable, !dbg !22
                                                  ; No predecessors!
  br label %cond.end, !dbg !24

cond.end:                                         ; preds = %1, %cond.true
  %2 = load i32, i32* %x, align 4, !dbg !26
  %cmp2 = icmp eq i32 %2, 5, !dbg !26
  br i1 %cmp2, label %cond.true3, label %cond.false4, !dbg !26

cond.true3:                                       ; preds = %cond.end
  br label %cond.end5, !dbg !27

cond.false4:                                      ; preds = %cond.end
  call void @__assert_fail(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.2, i32 0, i32 0), i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.1, i32 0, i32 0), i32 14, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @__PRETTY_FUNCTION__.main, i32 0, i32 0)) #3, !dbg !29
  unreachable, !dbg !29
                                                  ; No predecessors!
  br label %cond.end5, !dbg !31

cond.end5:                                        ; preds = %3, %cond.true3
  call void @llvm.dbg.declare(metadata i32* %glob, metadata !33, metadata !14), !dbg !34
  store i32 5, i32* %glob, align 4, !dbg !34
  %4 = load i32, i32* %glob, align 4, !dbg !35
  %cmp6 = icmp eq i32 %4, 5, !dbg !35
  br i1 %cmp6, label %cond.true7, label %cond.false8, !dbg !35

cond.true7:                                       ; preds = %cond.end5
  br label %cond.end9, !dbg !36

cond.false8:                                      ; preds = %cond.end5
  call void @__assert_fail(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.3, i32 0, i32 0), i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.1, i32 0, i32 0), i32 18, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @__PRETTY_FUNCTION__.main, i32 0, i32 0)) #3, !dbg !37
  unreachable, !dbg !37
                                                  ; No predecessors!
  br label %cond.end9, !dbg !38

cond.end9:                                        ; preds = %5, %cond.true7
  call void @llvm.dbg.declare(metadata i32* %y, metadata !39, metadata !14), !dbg !41
  store i32 10, i32* %y, align 4, !dbg !41
  %6 = load i32, i32* %x, align 4, !dbg !42
  %7 = load i32, i32* %y, align 4, !dbg !42
  %add = add nsw i32 %6, %7, !dbg !42
  %cmp10 = icmp eq i32 %add, 15, !dbg !42
  br i1 %cmp10, label %cond.true11, label %cond.false12, !dbg !42

cond.true11:                                      ; preds = %cond.end9
  br label %cond.end13, !dbg !43

cond.false12:                                     ; preds = %cond.end9
  call void @__assert_fail(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.4, i32 0, i32 0), i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.1, i32 0, i32 0), i32 22, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @__PRETTY_FUNCTION__.main, i32 0, i32 0)) #3, !dbg !45
  unreachable, !dbg !45
                                                  ; No predecessors!
  br label %cond.end13, !dbg !47

cond.end13:                                       ; preds = %8, %cond.true11
  ret i32 0, !dbg !49
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noreturn nounwind
declare void @__assert_fail(i8*, i8*, i32, i8*) #2

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { noreturn nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { noreturn nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!7, !8}
!llvm.ident = !{!9}

!0 = !DIGlobalVariableExpression(var: !1)
!1 = distinct !DIGlobalVariable(name: "glob", scope: !2, file: !3, line: 2, type: !6, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 5.0.0 (trunk 295264)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !5)
!3 = !DIFile(filename: "variable_scopes/main.c", directory: "/home/rasika/llvm2goto/llvm2goto-regression-master")
!4 = !{}
!5 = !{!0}
!6 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!7 = !{i32 2, !"Dwarf Version", i32 4}
!8 = !{i32 2, !"Debug Info Version", i32 3}
!9 = !{!"clang version 5.0.0 (trunk 295264)"}
!10 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 4, type: !11, isLocal: false, isDefinition: true, scopeLine: 5, isOptimized: false, unit: !2, variables: !4)
!11 = !DISubroutineType(types: !12)
!12 = !{!6}
!13 = !DILocalVariable(name: "x", scope: !10, file: !3, line: 6, type: !6)
!14 = !DIExpression()
!15 = !DILocation(line: 6, column: 6, scope: !10)
!16 = !DILocalVariable(name: "x", scope: !17, file: !3, line: 9, type: !6)
!17 = distinct !DILexicalBlock(scope: !10, file: !3, line: 8, column: 2)
!18 = !DILocation(line: 9, column: 7, scope: !17)
!19 = !DILocation(line: 11, column: 3, scope: !17)
!20 = !DILocation(line: 11, column: 3, scope: !21)
!21 = !DILexicalBlockFile(scope: !17, file: !3, discriminator: 2)
!22 = !DILocation(line: 11, column: 3, scope: !23)
!23 = !DILexicalBlockFile(scope: !17, file: !3, discriminator: 4)
!24 = !DILocation(line: 11, column: 3, scope: !25)
!25 = !DILexicalBlockFile(scope: !17, file: !3, discriminator: 6)
!26 = !DILocation(line: 14, column: 2, scope: !10)
!27 = !DILocation(line: 14, column: 2, scope: !28)
!28 = !DILexicalBlockFile(scope: !10, file: !3, discriminator: 2)
!29 = !DILocation(line: 14, column: 2, scope: !30)
!30 = !DILexicalBlockFile(scope: !10, file: !3, discriminator: 4)
!31 = !DILocation(line: 14, column: 2, scope: !32)
!32 = !DILexicalBlockFile(scope: !10, file: !3, discriminator: 6)
!33 = !DILocalVariable(name: "glob", scope: !10, file: !3, line: 16, type: !6)
!34 = !DILocation(line: 16, column: 6, scope: !10)
!35 = !DILocation(line: 18, column: 2, scope: !10)
!36 = !DILocation(line: 18, column: 2, scope: !28)
!37 = !DILocation(line: 18, column: 2, scope: !30)
!38 = !DILocation(line: 18, column: 2, scope: !32)
!39 = !DILocalVariable(name: "y", scope: !40, file: !3, line: 21, type: !6)
!40 = distinct !DILexicalBlock(scope: !10, file: !3, line: 20, column: 2)
!41 = !DILocation(line: 21, column: 7, scope: !40)
!42 = !DILocation(line: 22, column: 3, scope: !40)
!43 = !DILocation(line: 22, column: 3, scope: !44)
!44 = !DILexicalBlockFile(scope: !40, file: !3, discriminator: 2)
!45 = !DILocation(line: 22, column: 3, scope: !46)
!46 = !DILexicalBlockFile(scope: !40, file: !3, discriminator: 4)
!47 = !DILocation(line: 22, column: 3, scope: !48)
!48 = !DILexicalBlockFile(scope: !40, file: !3, discriminator: 6)
!49 = !DILocation(line: 25, column: 2, scope: !10)
