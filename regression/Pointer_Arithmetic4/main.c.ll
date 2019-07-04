; ModuleID = 'Pointer_Arithmetic4/main.c'
source_filename = "Pointer_Arithmetic4/main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !10 {
entry:
  %retval = alloca i32, align 4
  %i = alloca i32, align 4
  %ii = alloca i32, align 4
  %data = alloca i32, align 4
  %p = alloca i8*, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %i, metadata !14, metadata !DIExpression()), !dbg !15
  call void @llvm.dbg.declare(metadata i32* %ii, metadata !16, metadata !DIExpression()), !dbg !17
  call void @llvm.dbg.declare(metadata i32* %data, metadata !18, metadata !DIExpression()), !dbg !19
  store i32 0, i32* %data, align 4, !dbg !19
  call void @llvm.dbg.declare(metadata i8** %p, metadata !20, metadata !DIExpression()), !dbg !21
  %0 = bitcast i32* %data to i8*, !dbg !22
  store i8* %0, i8** %p, align 8, !dbg !21
  %1 = load i32, i32* %ii, align 4, !dbg !23
  store i32 %1, i32* %i, align 4, !dbg !24
  %2 = load i32, i32* %i, align 4, !dbg !25
  %cmp = icmp sge i32 %2, 0, !dbg !26
  %conv = zext i1 %cmp to i32, !dbg !26
  %call = call i32 (i32, ...) bitcast (i32 (...)* @__CPROVER_assume to i32 (i32, ...)*)(i32 %conv), !dbg !27
  %3 = load i32, i32* %i, align 4, !dbg !28
  %cmp1 = icmp slt i32 %3, 4, !dbg !29
  %conv2 = zext i1 %cmp1 to i32, !dbg !29
  %call3 = call i32 (i32, ...) bitcast (i32 (...)* @__CPROVER_assume to i32 (i32, ...)*)(i32 %conv2), !dbg !30
  %4 = load i8*, i8** %p, align 8, !dbg !31
  %5 = load i32, i32* %i, align 4, !dbg !32
  %idxprom = sext i32 %5 to i64, !dbg !31
  %arrayidx = getelementptr inbounds i8, i8* %4, i64 %idxprom, !dbg !31
  %6 = load i8, i8* %arrayidx, align 1, !dbg !33
  %inc = add i8 %6, 1, !dbg !33
  store i8 %inc, i8* %arrayidx, align 1, !dbg !33
  %7 = load i32, i32* %i, align 4, !dbg !34
  %cmp4 = icmp eq i32 %7, 0, !dbg !36
  br i1 %cmp4, label %if.then, label %if.else, !dbg !37

if.then:                                          ; preds = %entry
  %8 = load i32, i32* %data, align 4, !dbg !38
  %cmp6 = icmp eq i32 %8, 1, !dbg !39
  %conv7 = zext i1 %cmp6 to i32, !dbg !39
  %call8 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv7), !dbg !40
  br label %if.end27, !dbg !40

if.else:                                          ; preds = %entry
  %9 = load i32, i32* %i, align 4, !dbg !41
  %cmp9 = icmp eq i32 %9, 1, !dbg !43
  br i1 %cmp9, label %if.then11, label %if.else15, !dbg !44

if.then11:                                        ; preds = %if.else
  %10 = load i32, i32* %data, align 4, !dbg !45
  %cmp12 = icmp eq i32 %10, 256, !dbg !46
  %conv13 = zext i1 %cmp12 to i32, !dbg !46
  %call14 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv13), !dbg !47
  br label %if.end26, !dbg !47

if.else15:                                        ; preds = %if.else
  %11 = load i32, i32* %i, align 4, !dbg !48
  %cmp16 = icmp eq i32 %11, 2, !dbg !50
  br i1 %cmp16, label %if.then18, label %if.else22, !dbg !51

if.then18:                                        ; preds = %if.else15
  %12 = load i32, i32* %data, align 4, !dbg !52
  %cmp19 = icmp eq i32 %12, 65536, !dbg !53
  %conv20 = zext i1 %cmp19 to i32, !dbg !53
  %call21 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv20), !dbg !54
  br label %if.end, !dbg !54

if.else22:                                        ; preds = %if.else15
  %13 = load i32, i32* %data, align 4, !dbg !55
  %cmp23 = icmp eq i32 %13, 16777216, !dbg !56
  %conv24 = zext i1 %cmp23 to i32, !dbg !56
  %call25 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv24), !dbg !57
  br label %if.end

if.end:                                           ; preds = %if.else22, %if.then18
  br label %if.end26

if.end26:                                         ; preds = %if.end, %if.then11
  br label %if.end27

if.end27:                                         ; preds = %if.end26, %if.then
  %14 = load i32, i32* %retval, align 4, !dbg !58
  ret i32 %14, !dbg !58
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare dso_local i32 @__CPROVER_assume(...) #2

declare dso_local i32 @assert(...) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!6, !7, !8}
!llvm.ident = !{!9}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 8.0.0 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3, nameTableKind: None)
!1 = !DIFile(filename: "Pointer_Arithmetic4/main.c", directory: "/home/akash/Documents/CBMC/cbmc/src/llvm2goto/regression")
!2 = !{}
!3 = !{!4}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !5, size: 64)
!5 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!6 = !{i32 2, !"Dwarf Version", i32 4}
!7 = !{i32 2, !"Debug Info Version", i32 3}
!8 = !{i32 1, !"wchar_size", i32 4}
!9 = !{!"clang version 8.0.0 "}
!10 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 1, type: !11, scopeLine: 2, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!11 = !DISubroutineType(types: !12)
!12 = !{!13}
!13 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!14 = !DILocalVariable(name: "i", scope: !10, file: !1, line: 3, type: !13)
!15 = !DILocation(line: 3, column: 7, scope: !10)
!16 = !DILocalVariable(name: "ii", scope: !10, file: !1, line: 3, type: !13)
!17 = !DILocation(line: 3, column: 10, scope: !10)
!18 = !DILocalVariable(name: "data", scope: !10, file: !1, line: 4, type: !13)
!19 = !DILocation(line: 4, column: 7, scope: !10)
!20 = !DILocalVariable(name: "p", scope: !10, file: !1, line: 5, type: !4)
!21 = !DILocation(line: 5, column: 9, scope: !10)
!22 = !DILocation(line: 5, column: 11, scope: !10)
!23 = !DILocation(line: 6, column: 5, scope: !10)
!24 = !DILocation(line: 6, column: 4, scope: !10)
!25 = !DILocation(line: 8, column: 20, scope: !10)
!26 = !DILocation(line: 8, column: 21, scope: !10)
!27 = !DILocation(line: 8, column: 3, scope: !10)
!28 = !DILocation(line: 9, column: 20, scope: !10)
!29 = !DILocation(line: 9, column: 21, scope: !10)
!30 = !DILocation(line: 9, column: 3, scope: !10)
!31 = !DILocation(line: 10, column: 3, scope: !10)
!32 = !DILocation(line: 10, column: 5, scope: !10)
!33 = !DILocation(line: 10, column: 7, scope: !10)
!34 = !DILocation(line: 12, column: 6, scope: !35)
!35 = distinct !DILexicalBlock(scope: !10, file: !1, line: 12, column: 6)
!36 = !DILocation(line: 12, column: 7, scope: !35)
!37 = !DILocation(line: 12, column: 6, scope: !10)
!38 = !DILocation(line: 13, column: 12, scope: !35)
!39 = !DILocation(line: 13, column: 16, scope: !35)
!40 = !DILocation(line: 13, column: 5, scope: !35)
!41 = !DILocation(line: 14, column: 11, scope: !42)
!42 = distinct !DILexicalBlock(scope: !35, file: !1, line: 14, column: 11)
!43 = !DILocation(line: 14, column: 12, scope: !42)
!44 = !DILocation(line: 14, column: 11, scope: !35)
!45 = !DILocation(line: 15, column: 12, scope: !42)
!46 = !DILocation(line: 15, column: 16, scope: !42)
!47 = !DILocation(line: 15, column: 5, scope: !42)
!48 = !DILocation(line: 16, column: 11, scope: !49)
!49 = distinct !DILexicalBlock(scope: !42, file: !1, line: 16, column: 11)
!50 = !DILocation(line: 16, column: 12, scope: !49)
!51 = !DILocation(line: 16, column: 11, scope: !42)
!52 = !DILocation(line: 17, column: 12, scope: !49)
!53 = !DILocation(line: 17, column: 16, scope: !49)
!54 = !DILocation(line: 17, column: 5, scope: !49)
!55 = !DILocation(line: 19, column: 12, scope: !49)
!56 = !DILocation(line: 19, column: 16, scope: !49)
!57 = !DILocation(line: 19, column: 5, scope: !49)
!58 = !DILocation(line: 20, column: 1, scope: !10)
