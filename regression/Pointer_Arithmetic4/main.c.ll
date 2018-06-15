; ModuleID = 'Pointer_Arithmetic4/main.c'
source_filename = "Pointer_Arithmetic4/main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define i32 @main() #0 !dbg !9 {
entry:
  %retval = alloca i32, align 4
  %i = alloca i32, align 4
  %ii = alloca i32, align 4
  %data = alloca i32, align 4
  %p = alloca i8*, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %i, metadata !13, metadata !14), !dbg !15
  call void @llvm.dbg.declare(metadata i32* %ii, metadata !16, metadata !14), !dbg !17
  call void @llvm.dbg.declare(metadata i32* %data, metadata !18, metadata !14), !dbg !19
  store i32 0, i32* %data, align 4, !dbg !19
  call void @llvm.dbg.declare(metadata i8** %p, metadata !20, metadata !14), !dbg !21
  %0 = bitcast i32* %data to i8*, !dbg !22
  store i8* %0, i8** %p, align 8, !dbg !21
  %1 = load i32, i32* %ii, align 4, !dbg !23
  store i32 %1, i32* %i, align 4, !dbg !24
  %2 = load i32, i32* %i, align 4, !dbg !25
  %cmp = icmp sge i32 %2, 0, !dbg !26
  br i1 %cmp, label %land.rhs, label %land.end, !dbg !27

land.rhs:                                         ; preds = %entry
  %3 = load i32, i32* %i, align 4, !dbg !28
  %cmp1 = icmp slt i32 %3, 4, !dbg !30
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %4 = phi i1 [ false, %entry ], [ %cmp1, %land.rhs ]
  %land.ext = zext i1 %4 to i32, !dbg !31
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assume to i32 (i32, ...)*)(i32 %land.ext), !dbg !33
  %5 = load i8*, i8** %p, align 8, !dbg !34
  %6 = load i32, i32* %i, align 4, !dbg !35
  %idxprom = sext i32 %6 to i64, !dbg !34
  %arrayidx = getelementptr inbounds i8, i8* %5, i64 %idxprom, !dbg !34
  %7 = load i8, i8* %arrayidx, align 1, !dbg !36
  %inc = add i8 %7, 1, !dbg !36
  store i8 %inc, i8* %arrayidx, align 1, !dbg !36
  %8 = load i32, i32* %i, align 4, !dbg !37
  %cmp2 = icmp eq i32 %8, 0, !dbg !39
  br i1 %cmp2, label %if.then, label %if.else, !dbg !40

if.then:                                          ; preds = %land.end
  %9 = load i32, i32* %data, align 4, !dbg !41
  %cmp3 = icmp eq i32 %9, 1, !dbg !42
  %conv = zext i1 %cmp3 to i32, !dbg !42
  %call4 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !43
  br label %if.end23, !dbg !43

if.else:                                          ; preds = %land.end
  %10 = load i32, i32* %i, align 4, !dbg !44
  %cmp5 = icmp eq i32 %10, 1, !dbg !46
  br i1 %cmp5, label %if.then7, label %if.else11, !dbg !47

if.then7:                                         ; preds = %if.else
  %11 = load i32, i32* %data, align 4, !dbg !48
  %cmp8 = icmp eq i32 %11, 256, !dbg !49
  %conv9 = zext i1 %cmp8 to i32, !dbg !49
  %call10 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv9), !dbg !50
  br label %if.end22, !dbg !50

if.else11:                                        ; preds = %if.else
  %12 = load i32, i32* %i, align 4, !dbg !51
  %cmp12 = icmp eq i32 %12, 2, !dbg !53
  br i1 %cmp12, label %if.then14, label %if.else18, !dbg !54

if.then14:                                        ; preds = %if.else11
  %13 = load i32, i32* %data, align 4, !dbg !55
  %cmp15 = icmp eq i32 %13, 65536, !dbg !56
  %conv16 = zext i1 %cmp15 to i32, !dbg !56
  %call17 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv16), !dbg !57
  br label %if.end, !dbg !57

if.else18:                                        ; preds = %if.else11
  %14 = load i32, i32* %data, align 4, !dbg !58
  %cmp19 = icmp eq i32 %14, 16777216, !dbg !59
  %conv20 = zext i1 %cmp19 to i32, !dbg !59
  %call21 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv20), !dbg !60
  br label %if.end

if.end:                                           ; preds = %if.else18, %if.then14
  br label %if.end22

if.end22:                                         ; preds = %if.end, %if.then7
  br label %if.end23

if.end23:                                         ; preds = %if.end22, %if.then
  %15 = load i32, i32* %retval, align 4, !dbg !61
  ret i32 %15, !dbg !61
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i32 @assume(...) #2

declare i32 @assert(...) #2

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!6, !7}
!llvm.ident = !{!8}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.0 (trunk 295264)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3)
!1 = !DIFile(filename: "Pointer_Arithmetic4/main.c", directory: "/home/rasika/llvm2goto/llvm2goto-regression-master")
!2 = !{}
!3 = !{!4}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !5, size: 64)
!5 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!6 = !{i32 2, !"Dwarf Version", i32 4}
!7 = !{i32 2, !"Debug Info Version", i32 3}
!8 = !{!"clang version 5.0.0 (trunk 295264)"}
!9 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 1, type: !10, isLocal: false, isDefinition: true, scopeLine: 2, isOptimized: false, unit: !0, variables: !2)
!10 = !DISubroutineType(types: !11)
!11 = !{!12}
!12 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!13 = !DILocalVariable(name: "i", scope: !9, file: !1, line: 3, type: !12)
!14 = !DIExpression()
!15 = !DILocation(line: 3, column: 7, scope: !9)
!16 = !DILocalVariable(name: "ii", scope: !9, file: !1, line: 3, type: !12)
!17 = !DILocation(line: 3, column: 10, scope: !9)
!18 = !DILocalVariable(name: "data", scope: !9, file: !1, line: 4, type: !12)
!19 = !DILocation(line: 4, column: 7, scope: !9)
!20 = !DILocalVariable(name: "p", scope: !9, file: !1, line: 5, type: !4)
!21 = !DILocation(line: 5, column: 9, scope: !9)
!22 = !DILocation(line: 5, column: 11, scope: !9)
!23 = !DILocation(line: 6, column: 5, scope: !9)
!24 = !DILocation(line: 6, column: 4, scope: !9)
!25 = !DILocation(line: 8, column: 10, scope: !9)
!26 = !DILocation(line: 8, column: 11, scope: !9)
!27 = !DILocation(line: 8, column: 15, scope: !9)
!28 = !DILocation(line: 8, column: 18, scope: !29)
!29 = !DILexicalBlockFile(scope: !9, file: !1, discriminator: 2)
!30 = !DILocation(line: 8, column: 19, scope: !29)
!31 = !DILocation(line: 8, column: 15, scope: !32)
!32 = !DILexicalBlockFile(scope: !9, file: !1, discriminator: 4)
!33 = !DILocation(line: 8, column: 3, scope: !32)
!34 = !DILocation(line: 10, column: 3, scope: !9)
!35 = !DILocation(line: 10, column: 5, scope: !9)
!36 = !DILocation(line: 10, column: 7, scope: !9)
!37 = !DILocation(line: 12, column: 6, scope: !38)
!38 = distinct !DILexicalBlock(scope: !9, file: !1, line: 12, column: 6)
!39 = !DILocation(line: 12, column: 7, scope: !38)
!40 = !DILocation(line: 12, column: 6, scope: !9)
!41 = !DILocation(line: 13, column: 12, scope: !38)
!42 = !DILocation(line: 13, column: 16, scope: !38)
!43 = !DILocation(line: 13, column: 5, scope: !38)
!44 = !DILocation(line: 14, column: 11, scope: !45)
!45 = distinct !DILexicalBlock(scope: !38, file: !1, line: 14, column: 11)
!46 = !DILocation(line: 14, column: 12, scope: !45)
!47 = !DILocation(line: 14, column: 11, scope: !38)
!48 = !DILocation(line: 15, column: 12, scope: !45)
!49 = !DILocation(line: 15, column: 16, scope: !45)
!50 = !DILocation(line: 15, column: 5, scope: !45)
!51 = !DILocation(line: 16, column: 11, scope: !52)
!52 = distinct !DILexicalBlock(scope: !45, file: !1, line: 16, column: 11)
!53 = !DILocation(line: 16, column: 12, scope: !52)
!54 = !DILocation(line: 16, column: 11, scope: !45)
!55 = !DILocation(line: 17, column: 12, scope: !52)
!56 = !DILocation(line: 17, column: 16, scope: !52)
!57 = !DILocation(line: 17, column: 5, scope: !52)
!58 = !DILocation(line: 19, column: 12, scope: !52)
!59 = !DILocation(line: 19, column: 16, scope: !52)
!60 = !DILocation(line: 19, column: 5, scope: !52)
!61 = !DILocation(line: 20, column: 1, scope: !9)
