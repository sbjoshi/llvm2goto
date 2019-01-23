; ModuleID = 'typecheck/main.c'
source_filename = "typecheck/main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [10 x i8] c"a1 == 'b'\00", align 1
@.str.1 = private unnamed_addr constant [17 x i8] c"typecheck/main.c\00", align 1
@__PRETTY_FUNCTION__.main = private unnamed_addr constant [11 x i8] c"int main()\00", align 1
@.str.2 = private unnamed_addr constant [9 x i8] c"unsign>0\00", align 1
@.str.3 = private unnamed_addr constant [16 x i8] c"c >= 8394223.64\00", align 1
@.str.4 = private unnamed_addr constant [8 x i8] c"d == b2\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !9 {
entry:
  %retval = alloca i32, align 4
  %a1 = alloca i8, align 1
  %unsign = alloca i32, align 4
  %a = alloca double, align 8
  %b = alloca float, align 4
  %c = alloca double, align 8
  %b2 = alloca i64, align 8
  %d = alloca i64, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i8* %a1, metadata !11, metadata !DIExpression()), !dbg !13
  store i8 97, i8* %a1, align 1, !dbg !13
  %0 = load i8, i8* %a1, align 1, !dbg !14
  %conv = sext i8 %0 to i32, !dbg !14
  %add = add nsw i32 %conv, 1, !dbg !15
  %conv1 = trunc i32 %add to i8, !dbg !14
  store i8 %conv1, i8* %a1, align 1, !dbg !16
  %1 = load i8, i8* %a1, align 1, !dbg !17
  %conv2 = sext i8 %1 to i32, !dbg !17
  %cmp = icmp eq i32 %conv2, 98, !dbg !17
  br i1 %cmp, label %if.then, label %if.else, !dbg !20

if.then:                                          ; preds = %entry
  br label %if.end, !dbg !20

if.else:                                          ; preds = %entry
  call void @__assert_fail(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str, i32 0, i32 0), i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.1, i32 0, i32 0), i32 10, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @__PRETTY_FUNCTION__.main, i32 0, i32 0)) #3, !dbg !17
  unreachable, !dbg !17

if.end:                                           ; preds = %if.then
  call void @llvm.dbg.declare(metadata i32* %unsign, metadata !21, metadata !DIExpression()), !dbg !23
  store i32 0, i32* %unsign, align 4, !dbg !23
  %2 = load i32, i32* %unsign, align 4, !dbg !24
  %dec = add i32 %2, -1, !dbg !24
  store i32 %dec, i32* %unsign, align 4, !dbg !24
  %3 = load i32, i32* %unsign, align 4, !dbg !25
  %cmp4 = icmp ugt i32 %3, 0, !dbg !25
  br i1 %cmp4, label %if.then6, label %if.else7, !dbg !28

if.then6:                                         ; preds = %if.end
  br label %if.end8, !dbg !28

if.else7:                                         ; preds = %if.end
  call void @__assert_fail(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.2, i32 0, i32 0), i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.1, i32 0, i32 0), i32 16, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @__PRETTY_FUNCTION__.main, i32 0, i32 0)) #3, !dbg !25
  unreachable, !dbg !25

if.end8:                                          ; preds = %if.then6
  call void @llvm.dbg.declare(metadata double* %a, metadata !29, metadata !DIExpression()), !dbg !31
  store double 0x416002BDF3333333, double* %a, align 8, !dbg !31
  call void @llvm.dbg.declare(metadata float* %b, metadata !32, metadata !DIExpression()), !dbg !34
  store float 0x4059028F60000000, float* %b, align 4, !dbg !34
  call void @llvm.dbg.declare(metadata double* %c, metadata !35, metadata !DIExpression()), !dbg !36
  %4 = load double, double* %a, align 8, !dbg !37
  %5 = load float, float* %b, align 4, !dbg !38
  %conv9 = fpext float %5 to double, !dbg !38
  %add10 = fadd double %4, %conv9, !dbg !39
  store double %add10, double* %c, align 8, !dbg !40
  %6 = load double, double* %c, align 8, !dbg !41
  %cmp11 = fcmp oge double %6, 0x416002BDF47AE148, !dbg !41
  br i1 %cmp11, label %if.then13, label %if.else14, !dbg !44

if.then13:                                        ; preds = %if.end8
  br label %if.end15, !dbg !44

if.else14:                                        ; preds = %if.end8
  call void @__assert_fail(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.3, i32 0, i32 0), i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.1, i32 0, i32 0), i32 24, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @__PRETTY_FUNCTION__.main, i32 0, i32 0)) #3, !dbg !41
  unreachable, !dbg !41

if.end15:                                         ; preds = %if.then13
  call void @llvm.dbg.declare(metadata i64* %b2, metadata !45, metadata !DIExpression()), !dbg !47
  store i64 100, i64* %b2, align 8, !dbg !47
  call void @llvm.dbg.declare(metadata i64* %d, metadata !48, metadata !DIExpression()), !dbg !49
  %7 = load i64, i64* %b2, align 8, !dbg !50
  %sub = sub nsw i64 %7, 0, !dbg !51
  store i64 %sub, i64* %d, align 8, !dbg !49
  %8 = load i64, i64* %d, align 8, !dbg !52
  %9 = load i64, i64* %b2, align 8, !dbg !52
  %cmp16 = icmp eq i64 %8, %9, !dbg !52
  br i1 %cmp16, label %if.then18, label %if.else19, !dbg !55

if.then18:                                        ; preds = %if.end15
  br label %if.end20, !dbg !55

if.else19:                                        ; preds = %if.end15
  call void @__assert_fail(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.4, i32 0, i32 0), i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.1, i32 0, i32 0), i32 30, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @__PRETTY_FUNCTION__.main, i32 0, i32 0)) #3, !dbg !52
  unreachable, !dbg !52

if.end20:                                         ; preds = %if.then18
  ret i32 0, !dbg !56
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
!llvm.module.flags = !{!5, !6, !7}
!llvm.ident = !{!8}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 7.0.1 (https://github.com/llvm-mirror/clang.git 4519e2637fcc4bf6e3049a0a80e6a5e7b97667cb) (https://github.com/llvm-mirror/llvm.git cd98f42d0747826062fc3d2d2fad383aedf58dd6)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3)
!1 = !DIFile(filename: "typecheck/main.c", directory: "/home/akash/Documents/CBMC/cbmc/src/llvm2goto/regression")
!2 = !{}
!3 = !{!4}
!4 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!5 = !{i32 2, !"Dwarf Version", i32 4}
!6 = !{i32 2, !"Debug Info Version", i32 3}
!7 = !{i32 1, !"wchar_size", i32 4}
!8 = !{!"clang version 7.0.1 (https://github.com/llvm-mirror/clang.git 4519e2637fcc4bf6e3049a0a80e6a5e7b97667cb) (https://github.com/llvm-mirror/llvm.git cd98f42d0747826062fc3d2d2fad383aedf58dd6)"}
!9 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 4, type: !10, isLocal: false, isDefinition: true, scopeLine: 5, isOptimized: false, unit: !0, retainedNodes: !2)
!10 = !DISubroutineType(types: !3)
!11 = !DILocalVariable(name: "a1", scope: !9, file: !1, line: 7, type: !12)
!12 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!13 = !DILocation(line: 7, column: 7, scope: !9)
!14 = !DILocation(line: 8, column: 8, scope: !9)
!15 = !DILocation(line: 8, column: 10, scope: !9)
!16 = !DILocation(line: 8, column: 6, scope: !9)
!17 = !DILocation(line: 10, column: 3, scope: !18)
!18 = distinct !DILexicalBlock(scope: !19, file: !1, line: 10, column: 3)
!19 = distinct !DILexicalBlock(scope: !9, file: !1, line: 10, column: 3)
!20 = !DILocation(line: 10, column: 3, scope: !19)
!21 = !DILocalVariable(name: "unsign", scope: !9, file: !1, line: 13, type: !22)
!22 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!23 = !DILocation(line: 13, column: 16, scope: !9)
!24 = !DILocation(line: 14, column: 9, scope: !9)
!25 = !DILocation(line: 16, column: 3, scope: !26)
!26 = distinct !DILexicalBlock(scope: !27, file: !1, line: 16, column: 3)
!27 = distinct !DILexicalBlock(scope: !9, file: !1, line: 16, column: 3)
!28 = !DILocation(line: 16, column: 3, scope: !27)
!29 = !DILocalVariable(name: "a", scope: !9, file: !1, line: 19, type: !30)
!30 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!31 = !DILocation(line: 19, column: 10, scope: !9)
!32 = !DILocalVariable(name: "b", scope: !9, file: !1, line: 20, type: !33)
!33 = !DIBasicType(name: "float", size: 32, encoding: DW_ATE_float)
!34 = !DILocation(line: 20, column: 9, scope: !9)
!35 = !DILocalVariable(name: "c", scope: !9, file: !1, line: 21, type: !30)
!36 = !DILocation(line: 21, column: 10, scope: !9)
!37 = !DILocation(line: 22, column: 7, scope: !9)
!38 = !DILocation(line: 22, column: 9, scope: !9)
!39 = !DILocation(line: 22, column: 8, scope: !9)
!40 = !DILocation(line: 22, column: 5, scope: !9)
!41 = !DILocation(line: 24, column: 3, scope: !42)
!42 = distinct !DILexicalBlock(scope: !43, file: !1, line: 24, column: 3)
!43 = distinct !DILexicalBlock(scope: !9, file: !1, line: 24, column: 3)
!44 = !DILocation(line: 24, column: 3, scope: !43)
!45 = !DILocalVariable(name: "b2", scope: !9, file: !1, line: 27, type: !46)
!46 = !DIBasicType(name: "long int", size: 64, encoding: DW_ATE_signed)
!47 = !DILocation(line: 27, column: 8, scope: !9)
!48 = !DILocalVariable(name: "d", scope: !9, file: !1, line: 28, type: !46)
!49 = !DILocation(line: 28, column: 8, scope: !9)
!50 = !DILocation(line: 28, column: 12, scope: !9)
!51 = !DILocation(line: 28, column: 15, scope: !9)
!52 = !DILocation(line: 30, column: 3, scope: !53)
!53 = distinct !DILexicalBlock(scope: !54, file: !1, line: 30, column: 3)
!54 = distinct !DILexicalBlock(scope: !9, file: !1, line: 30, column: 3)
!55 = !DILocation(line: 30, column: 3, scope: !54)
!56 = !DILocation(line: 32, column: 3, scope: !9)
