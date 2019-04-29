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
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !27

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %i, align 4, !dbg !28
  %cmp1 = icmp slt i32 %3, 4, !dbg !29
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ], !dbg !30
  %land.ext = zext i1 %4 to i32, !dbg !27
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assume to i32 (i32, ...)*)(i32 %land.ext), !dbg !31
  %5 = load i8*, i8** %p, align 8, !dbg !32
  %6 = load i32, i32* %i, align 4, !dbg !33
  %idxprom = sext i32 %6 to i64, !dbg !32
  %arrayidx = getelementptr inbounds i8, i8* %5, i64 %idxprom, !dbg !32
  %7 = load i8, i8* %arrayidx, align 1, !dbg !34
  %inc = add i8 %7, 1, !dbg !34
  store i8 %inc, i8* %arrayidx, align 1, !dbg !34
  %8 = load i32, i32* %i, align 4, !dbg !35
  %cmp2 = icmp eq i32 %8, 0, !dbg !37
  br i1 %cmp2, label %if.then, label %if.else, !dbg !38

if.then:                                          ; preds = %land.end
  %9 = load i32, i32* %data, align 4, !dbg !39
  %cmp3 = icmp eq i32 %9, 1, !dbg !40
  %conv = zext i1 %cmp3 to i32, !dbg !40
  %call4 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !41
  br label %if.end23, !dbg !41

if.else:                                          ; preds = %land.end
  %10 = load i32, i32* %i, align 4, !dbg !42
  %cmp5 = icmp eq i32 %10, 1, !dbg !44
  br i1 %cmp5, label %if.then7, label %if.else11, !dbg !45

if.then7:                                         ; preds = %if.else
  %11 = load i32, i32* %data, align 4, !dbg !46
  %cmp8 = icmp eq i32 %11, 256, !dbg !47
  %conv9 = zext i1 %cmp8 to i32, !dbg !47
  %call10 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv9), !dbg !48
  br label %if.end22, !dbg !48

if.else11:                                        ; preds = %if.else
  %12 = load i32, i32* %i, align 4, !dbg !49
  %cmp12 = icmp eq i32 %12, 2, !dbg !51
  br i1 %cmp12, label %if.then14, label %if.else18, !dbg !52

if.then14:                                        ; preds = %if.else11
  %13 = load i32, i32* %data, align 4, !dbg !53
  %cmp15 = icmp eq i32 %13, 65536, !dbg !54
  %conv16 = zext i1 %cmp15 to i32, !dbg !54
  %call17 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv16), !dbg !55
  br label %if.end, !dbg !55

if.else18:                                        ; preds = %if.else11
  %14 = load i32, i32* %data, align 4, !dbg !56
  %cmp19 = icmp eq i32 %14, 16777216, !dbg !57
  %conv20 = zext i1 %cmp19 to i32, !dbg !57
  %call21 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv20), !dbg !58
  br label %if.end

if.end:                                           ; preds = %if.else18, %if.then14
  br label %if.end22

if.end22:                                         ; preds = %if.end, %if.then7
  br label %if.end23

if.end23:                                         ; preds = %if.end22, %if.then
  %15 = load i32, i32* %retval, align 4, !dbg !59
  ret i32 %15, !dbg !59
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare dso_local i32 @assume(...) #2

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
!25 = !DILocation(line: 8, column: 10, scope: !10)
!26 = !DILocation(line: 8, column: 11, scope: !10)
!27 = !DILocation(line: 8, column: 15, scope: !10)
!28 = !DILocation(line: 8, column: 18, scope: !10)
!29 = !DILocation(line: 8, column: 19, scope: !10)
!30 = !DILocation(line: 0, scope: !10)
!31 = !DILocation(line: 8, column: 3, scope: !10)
!32 = !DILocation(line: 10, column: 3, scope: !10)
!33 = !DILocation(line: 10, column: 5, scope: !10)
!34 = !DILocation(line: 10, column: 7, scope: !10)
!35 = !DILocation(line: 12, column: 6, scope: !36)
!36 = distinct !DILexicalBlock(scope: !10, file: !1, line: 12, column: 6)
!37 = !DILocation(line: 12, column: 7, scope: !36)
!38 = !DILocation(line: 12, column: 6, scope: !10)
!39 = !DILocation(line: 13, column: 12, scope: !36)
!40 = !DILocation(line: 13, column: 16, scope: !36)
!41 = !DILocation(line: 13, column: 5, scope: !36)
!42 = !DILocation(line: 14, column: 11, scope: !43)
!43 = distinct !DILexicalBlock(scope: !36, file: !1, line: 14, column: 11)
!44 = !DILocation(line: 14, column: 12, scope: !43)
!45 = !DILocation(line: 14, column: 11, scope: !36)
!46 = !DILocation(line: 15, column: 12, scope: !43)
!47 = !DILocation(line: 15, column: 16, scope: !43)
!48 = !DILocation(line: 15, column: 5, scope: !43)
!49 = !DILocation(line: 16, column: 11, scope: !50)
!50 = distinct !DILexicalBlock(scope: !43, file: !1, line: 16, column: 11)
!51 = !DILocation(line: 16, column: 12, scope: !50)
!52 = !DILocation(line: 16, column: 11, scope: !43)
!53 = !DILocation(line: 17, column: 12, scope: !50)
!54 = !DILocation(line: 17, column: 16, scope: !50)
!55 = !DILocation(line: 17, column: 5, scope: !50)
!56 = !DILocation(line: 19, column: 12, scope: !50)
!57 = !DILocation(line: 19, column: 16, scope: !50)
!58 = !DILocation(line: 19, column: 5, scope: !50)
!59 = !DILocation(line: 20, column: 1, scope: !10)
