; ModuleID = 'variable_scopes/main.c'
source_filename = "variable_scopes/main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@glob = dso_local global i32 10, align 4, !dbg !0
@.str = private unnamed_addr constant [6 x i8] c"x==10\00", align 1
@.str.1 = private unnamed_addr constant [23 x i8] c"variable_scopes/main.c\00", align 1
@__PRETTY_FUNCTION__.main = private unnamed_addr constant [11 x i8] c"int main()\00", align 1
@.str.2 = private unnamed_addr constant [5 x i8] c"x==5\00", align 1
@.str.3 = private unnamed_addr constant [9 x i8] c"glob ==5\00", align 1
@.str.4 = private unnamed_addr constant [10 x i8] c"x+y == 15\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !11 {
entry:
  %retval = alloca i32, align 4
  %x = alloca i32, align 4
  %x1 = alloca i32, align 4
  %glob = alloca i32, align 4
  %y = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %x, metadata !14, metadata !DIExpression()), !dbg !15
  store i32 5, i32* %x, align 4, !dbg !15
  call void @llvm.dbg.declare(metadata i32* %x1, metadata !16, metadata !DIExpression()), !dbg !18
  store i32 10, i32* %x1, align 4, !dbg !18
  %0 = load i32, i32* %x1, align 4, !dbg !19
  %cmp = icmp eq i32 %0, 10, !dbg !19
  br i1 %cmp, label %if.then, label %if.else, !dbg !22

if.then:                                          ; preds = %entry
  br label %if.end, !dbg !22

if.else:                                          ; preds = %entry
  call void @__assert_fail(i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str, i32 0, i32 0), i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.1, i32 0, i32 0), i32 11, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @__PRETTY_FUNCTION__.main, i32 0, i32 0)) #3, !dbg !19
  unreachable, !dbg !19

if.end:                                           ; preds = %if.then
  %1 = load i32, i32* %x, align 4, !dbg !23
  %cmp2 = icmp eq i32 %1, 5, !dbg !23
  br i1 %cmp2, label %if.then3, label %if.else4, !dbg !26

if.then3:                                         ; preds = %if.end
  br label %if.end5, !dbg !26

if.else4:                                         ; preds = %if.end
  call void @__assert_fail(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.2, i32 0, i32 0), i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.1, i32 0, i32 0), i32 14, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @__PRETTY_FUNCTION__.main, i32 0, i32 0)) #3, !dbg !23
  unreachable, !dbg !23

if.end5:                                          ; preds = %if.then3
  call void @llvm.dbg.declare(metadata i32* %glob, metadata !27, metadata !DIExpression()), !dbg !28
  store i32 5, i32* %glob, align 4, !dbg !28
  %2 = load i32, i32* %glob, align 4, !dbg !29
  %cmp6 = icmp eq i32 %2, 5, !dbg !29
  br i1 %cmp6, label %if.then7, label %if.else8, !dbg !32

if.then7:                                         ; preds = %if.end5
  br label %if.end9, !dbg !32

if.else8:                                         ; preds = %if.end5
  call void @__assert_fail(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.3, i32 0, i32 0), i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.1, i32 0, i32 0), i32 18, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @__PRETTY_FUNCTION__.main, i32 0, i32 0)) #3, !dbg !29
  unreachable, !dbg !29

if.end9:                                          ; preds = %if.then7
  call void @llvm.dbg.declare(metadata i32* %y, metadata !33, metadata !DIExpression()), !dbg !35
  store i32 10, i32* %y, align 4, !dbg !35
  %3 = load i32, i32* %x, align 4, !dbg !36
  %4 = load i32, i32* %y, align 4, !dbg !36
  %add = add nsw i32 %3, %4, !dbg !36
  %cmp10 = icmp eq i32 %add, 15, !dbg !36
  br i1 %cmp10, label %if.then11, label %if.else12, !dbg !39

if.then11:                                        ; preds = %if.end9
  br label %if.end13, !dbg !39

if.else12:                                        ; preds = %if.end9
  call void @__assert_fail(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.4, i32 0, i32 0), i8* getelementptr inbounds ([23 x i8], [23 x i8]* @.str.1, i32 0, i32 0), i32 22, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @__PRETTY_FUNCTION__.main, i32 0, i32 0)) #3, !dbg !36
  unreachable, !dbg !36

if.end13:                                         ; preds = %if.then11
  ret i32 0, !dbg !40
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noreturn nounwind
declare dso_local void @__assert_fail(i8*, i8*, i32, i8*) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { noreturn nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { noreturn nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!7, !8, !9}
!llvm.ident = !{!10}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "glob", scope: !2, file: !3, line: 2, type: !6, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 7.0.1 (https://github.com/llvm-mirror/clang.git 4519e2637fcc4bf6e3049a0a80e6a5e7b97667cb) (https://github.com/llvm-mirror/llvm.git cd98f42d0747826062fc3d2d2fad383aedf58dd6)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !5)
!3 = !DIFile(filename: "variable_scopes/main.c", directory: "/home/akash/Documents/CBMC/cbmc/src/llvm2goto/regression")
!4 = !{}
!5 = !{!0}
!6 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!7 = !{i32 2, !"Dwarf Version", i32 4}
!8 = !{i32 2, !"Debug Info Version", i32 3}
!9 = !{i32 1, !"wchar_size", i32 4}
!10 = !{!"clang version 7.0.1 (https://github.com/llvm-mirror/clang.git 4519e2637fcc4bf6e3049a0a80e6a5e7b97667cb) (https://github.com/llvm-mirror/llvm.git cd98f42d0747826062fc3d2d2fad383aedf58dd6)"}
!11 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 4, type: !12, isLocal: false, isDefinition: true, scopeLine: 5, isOptimized: false, unit: !2, retainedNodes: !4)
!12 = !DISubroutineType(types: !13)
!13 = !{!6}
!14 = !DILocalVariable(name: "x", scope: !11, file: !3, line: 6, type: !6)
!15 = !DILocation(line: 6, column: 6, scope: !11)
!16 = !DILocalVariable(name: "x", scope: !17, file: !3, line: 9, type: !6)
!17 = distinct !DILexicalBlock(scope: !11, file: !3, line: 8, column: 2)
!18 = !DILocation(line: 9, column: 7, scope: !17)
!19 = !DILocation(line: 11, column: 3, scope: !20)
!20 = distinct !DILexicalBlock(scope: !21, file: !3, line: 11, column: 3)
!21 = distinct !DILexicalBlock(scope: !17, file: !3, line: 11, column: 3)
!22 = !DILocation(line: 11, column: 3, scope: !21)
!23 = !DILocation(line: 14, column: 2, scope: !24)
!24 = distinct !DILexicalBlock(scope: !25, file: !3, line: 14, column: 2)
!25 = distinct !DILexicalBlock(scope: !11, file: !3, line: 14, column: 2)
!26 = !DILocation(line: 14, column: 2, scope: !25)
!27 = !DILocalVariable(name: "glob", scope: !11, file: !3, line: 16, type: !6)
!28 = !DILocation(line: 16, column: 6, scope: !11)
!29 = !DILocation(line: 18, column: 2, scope: !30)
!30 = distinct !DILexicalBlock(scope: !31, file: !3, line: 18, column: 2)
!31 = distinct !DILexicalBlock(scope: !11, file: !3, line: 18, column: 2)
!32 = !DILocation(line: 18, column: 2, scope: !31)
!33 = !DILocalVariable(name: "y", scope: !34, file: !3, line: 21, type: !6)
!34 = distinct !DILexicalBlock(scope: !11, file: !3, line: 20, column: 2)
!35 = !DILocation(line: 21, column: 7, scope: !34)
!36 = !DILocation(line: 22, column: 3, scope: !37)
!37 = distinct !DILexicalBlock(scope: !38, file: !3, line: 22, column: 3)
!38 = distinct !DILexicalBlock(scope: !34, file: !3, line: 22, column: 3)
!39 = !DILocation(line: 22, column: 3, scope: !38)
!40 = !DILocation(line: 25, column: 2, scope: !11)
