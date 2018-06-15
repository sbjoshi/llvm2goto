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

; Function Attrs: noinline nounwind uwtable
define i32 @main() #0 !dbg !8 {
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
  call void @llvm.dbg.declare(metadata i8* %a1, metadata !10, metadata !12), !dbg !13
  store i8 97, i8* %a1, align 1, !dbg !13
  %0 = load i8, i8* %a1, align 1, !dbg !14
  %conv = sext i8 %0 to i32, !dbg !14
  %add = add nsw i32 %conv, 1, !dbg !15
  %conv1 = trunc i32 %add to i8, !dbg !14
  store i8 %conv1, i8* %a1, align 1, !dbg !16
  %1 = load i8, i8* %a1, align 1, !dbg !17
  %conv2 = sext i8 %1 to i32, !dbg !17
  %cmp = icmp eq i32 %conv2, 98, !dbg !17
  br i1 %cmp, label %cond.true, label %cond.false, !dbg !17

cond.true:                                        ; preds = %entry
  br label %cond.end, !dbg !18

cond.false:                                       ; preds = %entry
  call void @__assert_fail(i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str, i32 0, i32 0), i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.1, i32 0, i32 0), i32 10, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @__PRETTY_FUNCTION__.main, i32 0, i32 0)) #3, !dbg !20
  unreachable, !dbg !20
                                                  ; No predecessors!
  br label %cond.end, !dbg !22

cond.end:                                         ; preds = %2, %cond.true
  call void @llvm.dbg.declare(metadata i32* %unsign, metadata !24, metadata !12), !dbg !26
  store i32 0, i32* %unsign, align 4, !dbg !26
  %3 = load i32, i32* %unsign, align 4, !dbg !27
  %dec = add i32 %3, -1, !dbg !27
  store i32 %dec, i32* %unsign, align 4, !dbg !27
  %4 = load i32, i32* %unsign, align 4, !dbg !28
  %cmp4 = icmp ugt i32 %4, 0, !dbg !28
  br i1 %cmp4, label %cond.true6, label %cond.false7, !dbg !28

cond.true6:                                       ; preds = %cond.end
  br label %cond.end8, !dbg !29

cond.false7:                                      ; preds = %cond.end
  call void @__assert_fail(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.2, i32 0, i32 0), i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.1, i32 0, i32 0), i32 16, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @__PRETTY_FUNCTION__.main, i32 0, i32 0)) #3, !dbg !30
  unreachable, !dbg !30
                                                  ; No predecessors!
  br label %cond.end8, !dbg !31

cond.end8:                                        ; preds = %5, %cond.true6
  call void @llvm.dbg.declare(metadata double* %a, metadata !32, metadata !12), !dbg !34
  store double 0x416002BDF3333333, double* %a, align 8, !dbg !34
  call void @llvm.dbg.declare(metadata float* %b, metadata !35, metadata !12), !dbg !37
  store float 0x4059028F60000000, float* %b, align 4, !dbg !37
  call void @llvm.dbg.declare(metadata double* %c, metadata !38, metadata !12), !dbg !39
  %6 = load double, double* %a, align 8, !dbg !40
  %7 = load float, float* %b, align 4, !dbg !41
  %conv9 = fpext float %7 to double, !dbg !41
  %add10 = fadd double %6, %conv9, !dbg !42
  store double %add10, double* %c, align 8, !dbg !43
  %8 = load double, double* %c, align 8, !dbg !44
  %cmp11 = fcmp oge double %8, 0x416002BDF47AE148, !dbg !44
  br i1 %cmp11, label %cond.true13, label %cond.false14, !dbg !44

cond.true13:                                      ; preds = %cond.end8
  br label %cond.end15, !dbg !45

cond.false14:                                     ; preds = %cond.end8
  call void @__assert_fail(i8* getelementptr inbounds ([16 x i8], [16 x i8]* @.str.3, i32 0, i32 0), i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.1, i32 0, i32 0), i32 24, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @__PRETTY_FUNCTION__.main, i32 0, i32 0)) #3, !dbg !46
  unreachable, !dbg !46
                                                  ; No predecessors!
  br label %cond.end15, !dbg !47

cond.end15:                                       ; preds = %9, %cond.true13
  call void @llvm.dbg.declare(metadata i64* %b2, metadata !48, metadata !12), !dbg !50
  store i64 100, i64* %b2, align 8, !dbg !50
  call void @llvm.dbg.declare(metadata i64* %d, metadata !51, metadata !12), !dbg !52
  %10 = load i64, i64* %b2, align 8, !dbg !53
  %sub = sub nsw i64 %10, 0, !dbg !54
  store i64 %sub, i64* %d, align 8, !dbg !52
  %11 = load i64, i64* %d, align 8, !dbg !55
  %12 = load i64, i64* %b2, align 8, !dbg !55
  %cmp16 = icmp eq i64 %11, %12, !dbg !55
  br i1 %cmp16, label %cond.true18, label %cond.false19, !dbg !55

cond.true18:                                      ; preds = %cond.end15
  br label %cond.end20, !dbg !56

cond.false19:                                     ; preds = %cond.end15
  call void @__assert_fail(i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str.4, i32 0, i32 0), i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.1, i32 0, i32 0), i32 30, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @__PRETTY_FUNCTION__.main, i32 0, i32 0)) #3, !dbg !57
  unreachable, !dbg !57
                                                  ; No predecessors!
  br label %cond.end20, !dbg !58

cond.end20:                                       ; preds = %13, %cond.true18
  ret i32 0, !dbg !59
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
!llvm.module.flags = !{!5, !6}
!llvm.ident = !{!7}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.0 (trunk 295264)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3)
!1 = !DIFile(filename: "typecheck/main.c", directory: "/home/rasika/llvm2goto/llvm2goto-regression-master")
!2 = !{}
!3 = !{!4}
!4 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!5 = !{i32 2, !"Dwarf Version", i32 4}
!6 = !{i32 2, !"Debug Info Version", i32 3}
!7 = !{!"clang version 5.0.0 (trunk 295264)"}
!8 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 4, type: !9, isLocal: false, isDefinition: true, scopeLine: 5, isOptimized: false, unit: !0, variables: !2)
!9 = !DISubroutineType(types: !3)
!10 = !DILocalVariable(name: "a1", scope: !8, file: !1, line: 7, type: !11)
!11 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!12 = !DIExpression()
!13 = !DILocation(line: 7, column: 7, scope: !8)
!14 = !DILocation(line: 8, column: 8, scope: !8)
!15 = !DILocation(line: 8, column: 10, scope: !8)
!16 = !DILocation(line: 8, column: 6, scope: !8)
!17 = !DILocation(line: 10, column: 3, scope: !8)
!18 = !DILocation(line: 10, column: 3, scope: !19)
!19 = !DILexicalBlockFile(scope: !8, file: !1, discriminator: 2)
!20 = !DILocation(line: 10, column: 3, scope: !21)
!21 = !DILexicalBlockFile(scope: !8, file: !1, discriminator: 4)
!22 = !DILocation(line: 10, column: 3, scope: !23)
!23 = !DILexicalBlockFile(scope: !8, file: !1, discriminator: 6)
!24 = !DILocalVariable(name: "unsign", scope: !8, file: !1, line: 13, type: !25)
!25 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!26 = !DILocation(line: 13, column: 16, scope: !8)
!27 = !DILocation(line: 14, column: 9, scope: !8)
!28 = !DILocation(line: 16, column: 3, scope: !8)
!29 = !DILocation(line: 16, column: 3, scope: !19)
!30 = !DILocation(line: 16, column: 3, scope: !21)
!31 = !DILocation(line: 16, column: 3, scope: !23)
!32 = !DILocalVariable(name: "a", scope: !8, file: !1, line: 19, type: !33)
!33 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!34 = !DILocation(line: 19, column: 10, scope: !8)
!35 = !DILocalVariable(name: "b", scope: !8, file: !1, line: 20, type: !36)
!36 = !DIBasicType(name: "float", size: 32, encoding: DW_ATE_float)
!37 = !DILocation(line: 20, column: 9, scope: !8)
!38 = !DILocalVariable(name: "c", scope: !8, file: !1, line: 21, type: !33)
!39 = !DILocation(line: 21, column: 10, scope: !8)
!40 = !DILocation(line: 22, column: 7, scope: !8)
!41 = !DILocation(line: 22, column: 9, scope: !8)
!42 = !DILocation(line: 22, column: 8, scope: !8)
!43 = !DILocation(line: 22, column: 5, scope: !8)
!44 = !DILocation(line: 24, column: 3, scope: !8)
!45 = !DILocation(line: 24, column: 3, scope: !19)
!46 = !DILocation(line: 24, column: 3, scope: !21)
!47 = !DILocation(line: 24, column: 3, scope: !23)
!48 = !DILocalVariable(name: "b2", scope: !8, file: !1, line: 27, type: !49)
!49 = !DIBasicType(name: "long int", size: 64, encoding: DW_ATE_signed)
!50 = !DILocation(line: 27, column: 8, scope: !8)
!51 = !DILocalVariable(name: "d", scope: !8, file: !1, line: 28, type: !49)
!52 = !DILocation(line: 28, column: 8, scope: !8)
!53 = !DILocation(line: 28, column: 12, scope: !8)
!54 = !DILocation(line: 28, column: 15, scope: !8)
!55 = !DILocation(line: 30, column: 3, scope: !8)
!56 = !DILocation(line: 30, column: 3, scope: !19)
!57 = !DILocation(line: 30, column: 3, scope: !21)
!58 = !DILocation(line: 30, column: 3, scope: !23)
!59 = !DILocation(line: 32, column: 3, scope: !8)
